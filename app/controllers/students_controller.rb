class StudentsController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :authenticate_user!
  before_action :set_student, only: [:show, :edit, :update, :destroy], except: [:import]

  before_action :check_permissions, only: [:new, :create, :import]

  # GET /students
  # GET /students.json
  def index
    @students = Student.order(sort_column + " " + sort_direction).paginate(:page => params[:page], :per_page => 15)
    # Example use of authorize using ability
    # authorize! :read, @students
  end

  # GET /students/1
  # GET /students/1.json
  def show
    return redirect_to root_path if current_user.role?(User::ROLE[:teacher]) || current_user.role?(User::ROLE[:office])

  end

  # GET /students/new
  def new
    @student = Student.new
    @siblings = []
    @not_siblings = []
  end

  # GET /students/1/edit
  def edit
    @fees = @student.fees.where(term: current_term).order('amount asc')
    @other_fees = Fee.where(term: current_term).where.not(id: @fees.map(&:id)).order('amount asc')
    
    @route = @student.route
    @report_template = if @student.grade.report_template
                        @student.grade.report_template
                      else
                        ReportTemplate.first
                      end
    @siblings = @student.siblings
    @not_siblings = Student.not_siblings(@student)
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
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

  def assign_fee
    @student_id = params[:student_id]
    @fee_id = params[:fee_id]

    @student = Student.find(@student_id)
    @fee = Fee.find(@fee_id)
    if @student && @fee && !(@student.fee_ids.include? @fee_id)
      @student.fees << @fee
    end

    redirect_to edit_student_path(@student)
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
    @report_template = if @student.grade.report_template
                        @student.grade.report_template
                      else
                        ReportTemplate.first
                      end
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
    @report_template = if @student.grade.report_template
                        @student.grade.report_template
                      else
                        ReportTemplate.first
                      end
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
    @report_template = if @student.grade.report_template
                        @student.grade.report_template
                      else
                        ReportTemplate.first
                      end
    respond_to do |format|
      format.js do
        @return_content = render_to_string(partial: 'students/form_enter_mark', locals: { student: @student, term_id: @term_id, report_template: @report_template })
      end
    end

  end

  def import
    
  end

  def save_import_student
    array_import = Student.import(params[:file])
    format = array_import[0]
    if format
      import_success = array_import[1]
      import_error = array_import[2]
      errors = array_import[3]
      if import_success > 0
        flash[:notice] = import_error > 0 ? "Student import success: #{import_success} and errors: #{import_error} in rows #{errors}" : "Student import success: #{import_success}"
        redirect_to root_path
      else
        flash[:alert] = import_error == 0 ? "Student import errors: #{import_success}" : "File errors"
        redirect_to import_student_path
      end
    else
      flash[:alert] = "File errors format"
      redirect_to import_student_path
    end
    
  end

  def delete_all
    if Student.destroy_all
      flash[:notice] = ' All students was successfully destroyed.'
    else
      flash[:alert] = "Delele errors"
    end
    redirect_to root_path
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
        :mobile
      )
    end

    def check_permissions
      redirect_to root_path unless current_user.role?("office")
    end
    def sort_column
      Student.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end
