class AttendancesController < ApplicationController
  before_action :authenticate_user!
  
  TRUE = '1'
  FALSE = '0'

  def student_attendance
    grade = Grade.find(params[:grade_id].to_i)
    @students = grade.students
  end

  def teacher_attendance
    @grade = Grade.find(params[:grade_id].to_i)
    @teacher = @grade.teacher 
  end


  def create
    # create attendance for that student in that day if we have not done before
    # other wise, update it
    start_of_the_day = if params[:attendance] && params[:attendance][:created_at]
                         params[:attendance][:created_at].to_date.beginning_of_day
                       else
                         Time.now.beginning_of_day
                       end
    end_of_the_day = if params[:attendance] && params[:attendance][:created_at]
                       params[:attendance][:created_at].to_date.end_of_day
                     else
                       Time.now.end_of_day
                     end
    if params[:student_id].present?
      @attendance = Attendance.where(
          "student_id = ? AND term_id = ? AND ? >= created_at AND created_at >= ?",
          params[:student_id],
          current_term,
          end_of_the_day,
          start_of_the_day
      ).first
      @attendance = Attendance.create(student_id: params[:student_id], term_id: current_term) unless @attendance
    elsif params[:teacher_id].present?
      @attendance = Attendance.where(
          "teacher_id = ? AND term_id = ? AND ? >= created_at AND created_at >= ?",
          params[:teacher_id],
          current_term,
          end_of_the_day,
          start_of_the_day
      ).first
      @attendance = Attendance.create(teacher_id: params[:teacher_id], term_id: current_term) unless @attendance
    end

    @attendance.update_attributes(type_action: params[:type_action]) if @attendance.present?

    respond_to do |format|
      format.js
    end
  end
end
