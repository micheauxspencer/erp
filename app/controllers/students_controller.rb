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
    
    @route = @student.route
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
    @fees = Fee.where(term: current_term).order('amount asc')
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
  end


  def assign_route
    @student_id = params[:student_id]
    @route_id = params[:route_id]

    @student = Student.find(@student_id)
    @route = Route.find(@route_id)
    if @student && @route && !@student.route
      @student.route = @route
      @student.save
    end
  end

  def payment

    @fee = Fee.where(id: params[:fee_id]).first
    @student = Student.where(id: params[:student_id]).first

    @charge = Charge.where(fee_id: params[:fee_id], student_id: params[:student_id]).first
    if @charge && (params[:amount].to_i != 0)
      @charge.update_attributes(amount: params[:amount].to_i)
    end

    @is_completed = (params[:amount].to_i == @fee.amount.to_i)
    @charge.update_attributes(is_completed: @is_completed)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:first_name, :middle_name, :last_name, :street, :city, :postal_code, :sin, :birthdate, :gender, :status, :trans_req, :tax_rec_req, :route_id, :route_fee, :pick_up, :drop_off, :last_shool_attended, :last_school_phone, {:sibling_ids => []}, {:fee_ids => []}, :f_first_name, :f_last_name, :f_phone, :f_cell, :f_work, :f_email, :m_first_name, :m_last_name, :m_phone, :m_cell, :m_work, :m_email, :custody, :emerg_1_name, :emerg_1_phone, :emerg_1_relation, :healthcard, :doctor_name, :doctor_phone, :grade_id, :enrolled)
    end
end
