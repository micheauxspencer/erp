class TermsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_term, only: [:show, :edit, :update, :destroy]

  def index
    @terms = Term.all
  end

  def show
  end

  def new
    @term = Term.new
  end

  def edit
  end

  def create
    @term = Term.new(term_params)

    respond_to do |format|
      if @term.save
        format.html { redirect_to @term, notice: 'Fee was successfully created.' }
        format.json { render :show, status: :created, location: @term }
      else
        format.html { render :new }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fees/1
  # PATCH/PUT /fees/1.json
  def update
    respond_to do |format|
      if @term.update(term_params)
        format.html { redirect_to @term, notice: 'Fee was successfully updated.' }
        format.json { render :show, status: :ok, location: @term }
      else
        format.html { render :edit }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fees/1
  # DELETE /fees/1.json
  def destroy
    @term.destroy
    respond_to do |format|
      format.html { redirect_to terms_url, notice: 'Fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_term
    @term = Term.find(params[:id])
  end

  def term_params
    params.require(:term).permit(:name, :acedemic_year_id)
  end

  def set_current_term
    cookies.permanent[:current_term] = params[:term_id]
    redirect_to request.referer || root_url
  end
end