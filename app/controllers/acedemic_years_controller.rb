class AcedemicYearsController < ApplicationController
  before_action :set_acedemic_year, only: [:show, :edit, :update, :destroy]

  # GET /acedemic_years
  # GET /acedemic_years.json
  def index
    @acedemic_years = AcedemicYear.all
  end

  # GET /acedemic_years/1
  # GET /acedemic_years/1.json
  def show
  end

  # GET /acedemic_years/new
  def new
    @acedemic_year = AcedemicYear.new
  end

  # GET /acedemic_years/1/edit
  def edit
  end

  # POST /acedemic_years
  # POST /acedemic_years.json
  def create
    @acedemic_year = AcedemicYear.new(acedemic_year_params)
    acedemic_year_last = AcedemicYear.try(:last)
    respond_to do |format|
      if @acedemic_year.save
        if @acedemic_year.present?
          if acedemic_year_last.present?
            list_grades = acedemic_year_last.grades.map{ |g| {name: g.name, acedemic_year_id: @acedemic_year.id} }
            Grade.create(list_grades)
            Term.create([
              {name: "First Term", acedemic_year_id: @acedemic_year.id},
              {name: "Second Term", acedemic_year_id: @acedemic_year.id},
              {name: "Third Term", acedemic_year_id: @acedemic_year.id}
            ])
          end
        end
        format.html { redirect_to @acedemic_year, notice: 'Acedemic year was successfully created.' }
        format.json { render :show, status: :created, location: @acedemic_year }
      else
        format.html { render :new }
        format.json { render json: @acedemic_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acedemic_years/1
  # PATCH/PUT /acedemic_years/1.json
  def update
    respond_to do |format|
      if @acedemic_year.update(acedemic_year_params)
        format.html { redirect_to @acedemic_year, notice: 'Acedemic year was successfully updated.' }
        format.json { render :show, status: :ok, location: @acedemic_year }
      else
        format.html { render :edit }
        format.json { render json: @acedemic_year.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acedemic_years/1
  # DELETE /acedemic_years/1.json
  def destroy
    acedemic_year_id =  @acedemic_year.try(:id)
    if @acedemic_year.destroy
      if cookies.permanent[:current_acedemic_year].to_i == acedemic_year_id
        acedemic_year_last = AcedemicYear.try(:last)
        cookies.permanent[:current_acedemic_year] = acedemic_year_last.try(:id)
        cookies.permanent[:current_term] = acedemic_year_last.try(:terms).try(:first).try(:id)
      end
      respond_to do |format|
        format.html { redirect_to acedemic_years_url, notice: 'Acedemic year was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @acedemic_year.errors, status: :unprocessable_entity }
      end
    end
   
  end

  def set_current_acedemic_year
    cookies.permanent[:current_acedemic_year] = params[:acedemic_year_id]
    acedemic_year = AcedemicYear.find(params[:acedemic_year_id])
    cookies.permanent[:current_term] = acedemic_year.try(:terms).try(:first).try(:id)
    redirect_to request.referer || root_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acedemic_year
      @acedemic_year = AcedemicYear.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acedemic_year_params
      params.require(:acedemic_year).permit(:year, :start_date, :end_date, :grade_ids => [], :fee_ids => [])
    end
end
