class AttendancesController < ApplicationController
  TRUE = '1'
  FALSE = '0'

  def index
    @students = Student.where(class_name_id: params[:class_id].to_i)
  end

  def create
    # create attendance for that student in that day if we have not done before
    # other wise, update it
    @attendance = Attendance.where(
        "student_id = ? AND term_id = ? AND ? >= created_at AND created_at >= ?",
        params[:student_id],
        current_term,
        Time.zone.now.end_of_day,
        Time.zone.now.beginning_of_day
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