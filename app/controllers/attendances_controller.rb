class AttendancesController < ApplicationController
  def index
    @students = Student.where(class_name_id: params[:class_id].to_i)
  end

  def create

  end
end