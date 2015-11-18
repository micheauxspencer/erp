class TermsController < ApplicationController
  before_filter :authenticate_user!

  def set_current_term
    cookies.permanent[:current_term] = params[:term_id]
    redirect_to request.referer || root_url
  end
end