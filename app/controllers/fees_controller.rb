class FeesController < ApplicationController
  before_action :set_fee, only: [:show, :edit, :update, :destroy]

  before_action :check_permissions

  # GET /fees
  # GET /fees.json
  def index
    @fees = Fee.all
  end

  # GET /fees/1
  # GET /fees/1.json
  def show
  end

  # GET /fees/new
  def new
    @fee = Fee.new
  end

  # GET /fees/1/edit
  def edit
  end

  # POST /fees
  # POST /fees.json
  def create
    @fee = Fee.new(fee_params)

    respond_to do |format|
      if @fee.save
        format.html { redirect_to @fee, notice: 'Fee was successfully created.' }
        format.json { render :show, status: :created, location: @fee }
      else
        format.html { render :new }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fees/1
  # PATCH/PUT /fees/1.json
  def update
    respond_to do |format|
      if @fee.update(fee_params)
        format.html { redirect_to @fee, notice: 'Fee was successfully updated.' }
        format.json { render :show, status: :ok, location: @fee }
      else
        format.html { render :edit }
        format.json { render json: @fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fees/1
  # DELETE /fees/1.json
  def destroy
    @fee.destroy
    respond_to do |format|
      format.html { redirect_to fees_url, notice: 'Fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def report_paid
    @student = Student.find(params[:student_id])
    @fees = Fee.get_fees_paid(@student.id)

    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"Fees Paid #{@student.name}.xls\"" } 
    end
  end

  def report_unpaid
    @student = Student.find(params[:student_id])
    @fees = Fee.get_fees_unpaid(@student.id)
    
    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"Fees Unpaid #{@student.name}.xls\"" }
    end
  end

  def report_by_family
    @student = Student.find(params[:student_id])
    @fees = @student.fees.where(term: current_term)
    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"Fees all #{@student.name}.xls\"" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fee
      @fee = Fee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fee_params
      params.require(:fee).permit(:name, :amount, :term_id)
    end

    def check_permissions
      redirect_to root_path unless current_user.role?("accounting")
    end
end
