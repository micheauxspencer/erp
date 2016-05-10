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

  def teachers
    @teachers = User.teachers.order('last_name, first_name ASC')
  end

  def show_teacher
    @user = User.find(params[:user_id])
  end

  def export_staff
    @users = User.all.order('last_name, first_name ASC')
    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"staff list.xlsx\"" } 
    end
  end

  def update_teacher
    @user = User.find(params[:user_id])
    if @user.update_attributes(user_params)
      redirect_to teachers_path, notice: 'Your profile was successfully updated.'
    else
      redirect_to profile_path, alert: 'Error.'
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :user_name, :role, :first_name, :last_name, :birth_date, :address, :phone)
    end

end
