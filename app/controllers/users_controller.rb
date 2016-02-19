class UsersController < ApplicationController

  def profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update_attributes(user_params)
      sign_in(@user, :bypass => true)
      redirect_to profile_path, notice: 'Your profile was successfully updated.'
    else
      redirect_to profile_path, alert: 'Error.'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :user_name, :role, :first_name, :last_name, :birth_date, :address, :phone)
    end

end
