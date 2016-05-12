class GradesController < ApplicationController
  before_action :set_grade, only: [:show, :edit, :update, :destroy, :export_students, :export_attendance]
  before_action :check_permissions, only: [:show, :create, :edit, :update, :destroy]
  # GET /grades
  # GET /grades.json
  def index
    @grades = current_user.role?("teacher")? current_user.grades : Grade.all
  end

  # GET /grades/1
  # GET /grades/1.json
  def show
    @students = Student.all
    @teachers = User.teachers
    @teacher = @grade.teacher
  end

  # GET /grades/new
  def new
    @grade = Grade.new
  end

  # GET /grades/1/edit
  def edit
  end

  # POST /grades
  # POST /grades.json
  def create
    @grade = Grade.new(grade_params)
    @grade.report_template = ReportTemplate.all.first
    respond_to do |format|
      if @grade.save
        format.html { redirect_to @grade, notice: 'Grade was successfully created.' }
        format.json { render :show, status: :created, location: @grade }
      else
        format.html { render :new }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grades/1
  # PATCH/PUT /grades/1.json
  def update
    respond_to do |format|
      if @grade.update(grade_params)
        format.html { redirect_to @grade, notice: 'Grade was successfully updated.' }
        format.json { render :show, status: :ok, location: @grade }
      else
        format.html { render :edit }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.json
  def destroy
    @grade.destroy
    respond_to do |format|
      format.html { redirect_to grades_url, notice: 'Grade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def enter_grade
    @grades = Grade.all
  end

  def add_template
    grade = Grade.find(params[:grade_id])
    grade.update_attributes(report_template_id: params[:tem_id].to_i)
    render json: { results: "success"}
  end

  def export_students
    @students = @grade.students.order('last_name, first_name ASC')
    @teacher = @grade.teacher
    respond_to do |format|
      format.html
      format.csv { send_data @students.to_csv }
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"Student List #{@grade.name}.xls\"" }
    end
  end

  def export_all
    @grades = Grade.all.order("name ASC")
    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"list grades.xls\"" }
    end
  end

  def export_attendance
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grade
      @grade = Grade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grade_params
      params.require(:grade).permit(:name, :teacher_id, :term_id, :report_template_id,student_ids: [])
    end

    def check_permissions
      redirect_to root_path unless current_user.role?("accounting")
    end
end
