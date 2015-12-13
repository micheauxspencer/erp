class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all

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
  end

  # GET /students/1/edit
  def edit
    # @all_fees = Fee.where(term: current_term).order('amount asc')

    @fees = @student.fees.where(term: current_term).order('amount asc')
    student_fee_ids = @fees.map {|f| f.id}

    @other_fees = Fee.where(term: current_term).where('id NOT IN (?)', student_fee_ids).order('amount asc')

    @route = @student.route
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
    report_template = if @student.grade
                        @student.grade.report_template
                      else
                        ReportTemplate.first
                      end
    @template_name = report_template ? report_template.name : 'No Template'

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:first_name, :middle_name, :last_name, :street, :city, :postal_code, :sin, :birthdate, :gender, :status, :trans_req, :tax_rec_req, :route_id, :route_fee, :pick_up, :drop_off, :last_shool_attended, :last_school_phone, {:sibling_ids => []}, {:fee_ids => []}, :f_first_name, :f_last_name, :f_phone, :f_cell, :f_work, :f_email, :m_first_name, :m_last_name, :m_phone, :m_cell, :m_work, :m_email, :custody, :emerg_1_name, :emerg_1_phone, :emerg_1_relation, :healthcard, :doctor_name, :doctor_phone, :grade_id, :enrolled, :medical_conditions)
    end
end
