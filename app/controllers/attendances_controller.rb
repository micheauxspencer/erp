class AttendancesController < ApplicationController
  TRUE = '1'
  FALSE = '0'

  def index
    @students = Student.where(grade_id: params[:grade_id].to_i)
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

    @attendance = Attendance.where(
        "student_id = ? AND term_id = ? AND ? >= created_at AND created_at >= ?",
        params[:student_id],
        current_term,
        end_of_the_day,
        start_of_the_day
    ).first

    @attendance = Attendance.create(student_id: params[:student_id], term_id: current_term) unless @attendance

    if params[:late] == TRUE
      @attendance.update_attributes(is_late: true, absence: false, term_id: current_term.to_i)
    elsif params[:absence] == TRUE
      @attendance.update_attributes(is_late: false, absence: true, term_id: current_term.to_i)
    end

    respond_to do |format|
      format.js
    end
  end
end
