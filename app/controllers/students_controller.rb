class StudentsController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :authenticate_user!
  before_action :set_student, only: [:show, :edit, :update, :destroy, :curricular, :family_report, :families_report, :export_attendance, :assign_fee, :unassign_fee], except: [:import, :export_all, :export_health, :export_route, :transferred]

  before_action :check_permissions, only: [:update, :enter_mark]
  before_action :check_accounting, only: [:new, :create, :import, :save_import_student, :destroy, :delete_all, :transferred, :set_transferred]
  before_action :set_current_acedemic_year, except: [:transferred]

  # GET /students
  # GET /students.json
  def index
    @current_year = params[:year].present? ? AcedemicYear.find_by(year: params[:year].to_i) : AcedemicYear.find(current_acedemic_year.to_i)

    if current_user.role?('teacher')
      @grades =  current_user.grades.where(acedemic_year_id: @current_year.id)
    else
      @grades = @current_year.grades
    end

    @grade = params[:grade] && params[:grade] != '' ? @current_year.grades.where("name LIKE ?",  "%#{params[:grade]}%").first : nil

    redirect_to root_path if current_user.role?('teacher') && @grade && !current_user.grades.include?(@grade)

    if @grade
      @students_all = Student.search_student( @grade.students.not_transferred, params[:search])
    elsif current_user.role?('teacher')
      @students_all = Student.search_student( current_user.students.select_student_by_year(@current_year).not_transferred, params[:search])
    else
      @students_all = Student.search_student( Student.select_student_by_year(@current_year).not_transferred, params[:search])
    end

    if params[:enrollment_year].present? && params[:enrollment_year].to_i !=  0
      @students_all = @students_all.where(enrollment_year: params[:enrollment_year].to_i)
    end

    @students = @students_all.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 100)
  end

  # GET /students/1
  # GET /students/1.json
  def show

  end

  # GET /students/new
  def new
    @student = Student.new
    @siblings = []
    @not_siblings = Student.not_transferred
    @parents = []
    @not_parents = Parent.all
  end

  # GET /students/1/edit
  def edit
    @fees = @student.fees.where(term: current_term).order('amount asc')
    @other_fees = Fee.where(term: current_term).where.not(id: @fees.map(&:id)).order('amount asc')

    @route = @student.route
    @report_template = @student.get_report_template
    @siblings = @student.siblings
    @not_siblings = Student.not_siblings(@student)

    @parents = @student.parents
    @not_parents = Parent.all - @parents
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        GradeStudent.create(student: @student, grade_id: student_params[:grade_id])
        GradeStudent.create(student: @student, grade_id: params[:student][:next_grade_id])
        parents = params[:parents].scan( /\d+/ ).map(&:to_i)
        unless parents.empty?
          parents.each do |parent_id|
            parent = Parent.find(parent_id)
            if parent.present?
              StudentParent.create(student_id: @student.id, parent_id: parent.id)

              siblings = parent.students
              unless siblings.empty?
                siblings.each do |sibling|
                  StudentSibling.create(student_id: @student.id, sibling_id: sibling.id) unless @student == sibling
                end
              end
            end

          end
        end

        siblings = params[:siblings].scan( /\d+/ ).map(&:to_i)
        unless siblings.empty?
          siblings.each do |sibling|
            StudentSibling.find_or_create_by(student_id: @student.id, sibling_id: sibling)
          end
        end

        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        grade_student = GradeStudent.where(student_id: @student.id).where(grade_id: @current_acedemic_year.grades.map(&:id)).try(:first)
        if grade_student.present? && grade_student.try(:grade_id) != student_params[:grade_id]
          grade_student.update_attributes(grade_id: student_params[:grade_id])
        else
          GradeStudent.create(student: @student, grade_id: student_params[:grade_id])
        end

        next_acedemic_year = AcedemicYear.next_acedemic_year(@current_acedemic_year)
        grade_student_next = GradeStudent.where(student_id: @student.id).where(grade_id: next_acedemic_year.try(:grades).to_a.map(&:id)).try(:first)
        if grade_student_next.present? && grade_student_next.try(:grade_id) != params[:student][:next_grade_id]
          grade_student_next.update_attributes(grade_id: params[:student][:next_grade_id])
        else
          GradeStudent.create(student: @student, grade_id: params[:student][:next_grade_id])
        end

        format.html { redirect_to students_path, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def transferred
    @student_transferred = Student.search_student( Student.transferred, params[:search]).paginate(:page => params[:page], :per_page => 100)
  end

  def assign_fee
    @fee = Fee.find(params[:fee_id])
    if @student && @fee && !(@student.fee_ids.include? params[:fee_id])
      @student.fees << @fee
    end

    @fees = @student.fees.where(term: current_term).order('amount asc')
    @other_fees = Fee.where(term: current_term).where.not(id: @fees.map(&:id)).order('amount asc')

    respond_to do |format|
      format.js do
        @return_content = render_to_string(partial: 'students/fee_management', locals: { student: @student, fees: @fees, other_fees: @other_fees })
      end
    end
  end

  def unassign_fee
    charge = Charge.where(student_id: @student.id, fee_id: params[:fee_id]).first
    charge.destroy if charge.present?

    @fees = @student.fees.where(term: current_term).order('amount asc')
    @other_fees = Fee.where(term: current_term).where.not(id: @fees.map(&:id)).order('amount asc')

    respond_to do |format|
      format.js do
        @return_content = render_to_string(partial: 'students/fee_management', locals: { student: @student, fees: @fees, other_fees: @other_fees })
      end
    end
  end


  def assign_route
    @student_id = params[:student_id]
    @route_id = params[:route_id]

    @student = Student.find(@student_id)
    @route = Route.find(@route_id)
    if @student && @route
      @student.route = @route
      @student.save
    end

    redirect_to edit_student_path(@student)
  end

  def payment

    @fee = Fee.where(id: params[:fee_id]).first
    @student = Student.where(id: params[:student_id]).first

    @charge = Charge.where(fee_id: params[:fee_id], student_id: params[:student_id]).first
    if @charge && params[:amount]
      @charge.update_attributes(amount: params[:amount].to_i)
    end

    @is_completed = (params[:amount].to_i >= @fee.amount.to_i)
    @charge.update_attributes(is_completed: @is_completed)
  end

  def term_snapshot
    # {"student_id"=>"1", "term_id"=>"1"}
    @student = Student.find(params[:student_id])
    @term = Term.find(params[:term_id])
    @student.grades.each do |grade|
      @grade = grade if grade.term_id == params[:term_id].to_i
    end
  end

  def export_pdf
    @student = Student.find(params[:student_id])
    @report_template = @student.get_report_template
    @template_name = @report_template ? @report_template.name : 'No Template'

    respond_to do |format|
      format.html
      format.pdf do
        render  pdf:  "report_student",
                layout:      'pdf',
                disposition: 'attachment',
                title:       'Report Student',
                template:    'students/export_pdf.pdf.erb',
                layout:      'pdf.html.erb',
                page_size:   'A4',
                show_as_html: params.key?('debug'),
                margin:      { top:    5,
                               bottom: 8,
                               left:   10,
                               right:  10 },
                save_as_htm: true,
                header:      { html: { template: 'students/header.pdf.erb' }},
                footer:      { html: { template: 'students/footer.pdf.erb' }}
      end
    end
  end

  def export_fee
    @student = Student.find(params[:student_id])
    @fees = @student.fees.where(term: current_term).order('amount asc')
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf:  "#{@student.first_name}_#{@student.last_name}_receipts",
                layout:      'pdf',
                disposition: 'attachment',
                title:       'Report Student',
                template:    'students/export_fee.pdf.erb',
                layout:      'pdf.html.erb',
                page_size:   'A4',
                show_as_html: params.key?('debug'),
                save_as_htm: true

      end
    end
  end

  def enter_mark
    @student = Student.find(params[:student_id])
    @report_template = @student.get_report_template
    @term_id = params[:term].present? ? params[:term] : current_term
  end

  def save_mark
    @student = Student.find(params[:student_id])
    term_student = TermStudent.find_or_create_by(student_id: params[:student_id], term_id: params[:term_id])
    @term = Term.find(params[:term_id])
    if @term.present?
      params[:evaluate_mark].each do |evaluate_id, mark|
        student_evaluate = StudentEvaluate.find_or_create_by(term_student_id: term_student.id, evaluate_id: evaluate_id)
        student_evaluate.update_attributes( mark: mark)
      end
      if params[:evaluate_avg].present?
        params[:evaluate_avg].each do |evaluate_id, avg|
          student_evaluate = StudentEvaluate.find_or_create_by(term_student_id: term_student.id, evaluate_id: evaluate_id)
          student_evaluate.update_attributes( avg: avg)
        end
      end

      Comment.find_or_create_by(term_student_id: term_student.id).update_attributes(content: params[:comment])

      flash[:notice] = "Save mark success"
      redirect_to "/students/#{@student.id}/enter_mark?term=#{@term.id}"
    else
      flash[:notice] = "Save mark errors"
      redirect_to enter_mark_path(@student)
    end
  end

  def select_term
    @student = Student.find(params[:student_id])
    @term = Term.find(params[:term_id])
    redirect_to root_path unless @term
    @term_id = @term.id
    @report_template = @student.get_report_template
    respond_to do |format|
      format.js do
        @return_content = render_to_string(partial: 'students/form_enter_mark', locals: { student: @student, term_id: @term_id, report_template: @report_template })
      end
    end

  end

  def import

  end

  def save_import_student
    if  Student.import_csv(params[:file])
      flash[:notice] = "Student import success."
      redirect_to root_path
    else
      flash[:alert] = "Student import errors."
      redirect_to import_student_path
    end

  end

  def delete_all
    if Student.delete_all
      flash[:notice] = 'All students was successfully destroyed.'
    else
      flash[:alert] = "Delele errors"
    end
    redirect_to root_path
  end

  def enroll
    student = Student.find(params[:student_id])
    if student.present? && student.update_attributes(:enrolled => params[:enrolled])
      render :json => { :result => "success"}
    else
      render :json => { :result => "not-success", :massage => student.errors.full_messages }
    end
  end

  def set_transferred
    student = Student.find(params[:student_id])
    if student.present? && student.update_attributes(:transferred => params[:transferred])
      render :json => { :result => "success"}
    else
      render :json => { :result => "not-success", :massage => student.errors.full_messages }
    end
  end

  def curricular
    @curricular = Curricular.where(student_id: @student.id).last.present? ? Curricular.where(student_id: @student.id).last : Curricular.new
  end

  def save_curricular
    @student = Student.find(params[:curricular][:student_id])
    if @student.present?
      @curricular = Curricular.find_or_create_by(student_id: @student.id)
      @curricular.update_attributes(content: params[:curricular][:content], acedemic_year_id: params[:curricular][:acedemic_year_id])
      flash[:notice] = 'Save curricular success.'
      redirect_to edit_student_path(@student)
    else
      redirect_to root_path
    end
  end

  def family_report
    @parents = @student.parents
    @siblings = @student.siblings
    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"Family Report #{@student.name}.xls\"" }
    end
  end

  def families_report
    @parents = @student.parents
    @children = Student.where('id IN (?)', @student.siblings.map(&:id) << @student.id)
    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"Families Report #{@student.name}.xls\"" }
    end
  end

  def export_all
    @students = params[:students].present? ? Student.where(id: params[:students].map{|id| id.to_i}).order('last_name ASC, first_name ASC') : Student.get_list_student( params[:grade_id], params[:search], params[:year], params[:enrollment_year]).order('last_name ASC, first_name ASC')
    name_file = "Student list" + Student.name_file( params[:grade_id], params[:search], params[:year], params[:enrollment_year]).to_s
    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"#{name_file}.xls\"" }
    end
  end

  def export_health
    @students = params[:students].present? ? Student.where(id: params[:students].map{|id| id.to_i}).order('last_name ASC, first_name ASC') : Student.get_list_student( params[:grade_id], params[:search], params[:year], params[:enrollment_year]).order('last_name ASC, first_name ASC')
    name_file = "Health information list" + Student.name_file( params[:grade_id], params[:search], params[:year], params[:enrollment_year]).to_s
    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"#{name_file}.xls\"" }
    end
  end

  def export_route
    @students = params[:students].present? ? Student.get_list_student( params[:grade_id], params[:search], params[:year], params[:enrollment_year]).where.not(route_id: nil).order('last_name ASC, first_name ASC') : Student.where(id: params[:students].map{|id| id.to_i}).where.not(route_id: nil).order('last_name ASC, first_name ASC')
    name_file = "Student route list" + Student.name_file( params[:grade_id], params[:search], params[:year], params[:enrollment_year]).to_s
    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"#{name_file}.xls\"" }
    end
  end

  def export_attendance

  end

  def add_next_grade
    student = Student.find(params[:student_id])
    acedemic_year = AcedemicYear.find(params[:acedemic_year_id])
    grade_student = GradeStudent.where(student_id: student.id).where(grade_id: acedemic_year.grades.map(&:id)).try(:first)
    if grade_student.present?
      if grade_student.update_attributes(grade_id: params[:grade_id].to_i)
        render json: { results: "success"}
      else
        render json: { results: "error"}
      end
    else
      if GradeStudent.create(student_id: student.id, grade_id: params[:grade_id].to_i)
        render json: { results: "success"}
      else
        render json: { results: "error"}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(
        :first_name,
        :middle_name,
        :last_name,
        :street,
        :city,
        :postal_code,
        :sin,
        :birthdate,
        :gender,
        :status,
        :trans_req,
        :tax_rec_req,
        :route_id,
        :route_fee,
        :pick_up,
        :drop_off,
        :last_shool_attended,
        :last_school_phone,
        {:sibling_ids => []},
        {:fee_ids => []},
        :emerg_2_name,
        :emerg_2_phone,
        :emerg_2_relation,
        :f_first_name,
        :f_last_name,
        :f_phone,
        :f_cell,
        :f_work,
        :f_email,
        :m_first_name,
        :m_last_name,
        :m_phone,
        :m_cell,
        :m_work,
        :m_email,
        :custody,
        :emerg_1_name,
        :emerg_1_phone,
        :emerg_1_relation,
        :healthcard,
        :doctor_name,
        :doctor_phone,
        :grade_id,
        :enrolled,
        :medical_conditions,
        :state,
        :nationality,
        :category,
        :country,
        :immediate_contact,
        :biometric,
        :admission_date,
        :f_home_address,
        :f_city,
        :f_state,
        :m_home_address,
        :m_city,
        :m_state,
        :phone,
        :mobile,
        :parents,
        :enrollment_year,
        :transferred
      )
    end

    def check_permissions
      redirect_to root_path unless current_user.role?("accounting") || current_user.role?("teacher")
    end

    def check_accounting
      redirect_to root_path unless current_user.role?("accounting")
    end

    def sort_column
      Student.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_current_acedemic_year
      @current_acedemic_year = AcedemicYear.find(current_acedemic_year)
    end
end
