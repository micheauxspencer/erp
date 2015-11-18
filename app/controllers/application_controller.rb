class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_filter :current_term

  def current_term
    return cookies[:current_term] ? cookies[:current_term] : (Term.last ? Term.last.id : 1) #for example default value
  end

  # Set this method as helper method to be able to use in views
  helper_method :current_term

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:user_name, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:user_name, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
        :user_name,
        :email,
        :password,
        :password_confirmation,
        :current_password,
        :first_name,
        :last_name,
        :address,
        :birth_date,
        :phone
    ) }
  end
end
