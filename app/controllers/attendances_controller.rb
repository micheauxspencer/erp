class AttendancesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :authenticate_user!

  TRUE = '1'
  FALSE = '0'

  def student_attendance
    grade = Grade.find(params[:grade_id].to_i)
    @students = grade.students.order(sort_column + " " + sort_direction)
  end

  def teacher_attendance
    @grade = Grade.find(params[:grade_id].to_i)
    @teacher = @grade.teacher 
  end

  def teacher_attendance_all
    @teachers = User.teachers.order(sort_column + " " + sort_direction)
  end


  def create
    # create attendance for that student in that day if we have not done before
    # other wise, update it
    day = params[:attendanced_at] ? params[:attendanced_at].to_date : Time.now.to_date

    if params[:student_id].present?
      @attendance = Attendance.where(
          "student_id = ? AND term_id = ? AND attendanced_at = ?",
          params[:student_id],
          current_term,
          day
      ).first
      @attendance = Attendance.create(student_id: params[:student_id], term_id: current_term, attendanced_at: params[:attendanced_at]) unless @attendance
    elsif params[:teacher_id].present?
      @attendance = Attendance.where(
          "teacher_id = ? AND term_id = ? AND attendanced_at = ?",
          params[:teacher_id],
          current_term,
          day
      ).first
      @attendance = Attendance.create(teacher_id: params[:teacher_id], term_id: current_term, attendanced_at: params[:attendanced_at]) unless @attendance
    end

    @attendance.update_attributes(type_action: params[:type_action]) if @attendance.present?

    respond_to do |format|
      format.js
    end
  end

  def export_by_student
    @student = Student.find(params[:report][:student_id].to_i)
    name_file = ""
    if params[:report][:day].present?
      name_file = params[:report][:day].to_s
      @attendances = Attendance.where(student_id: @student.id)
                               .where(attendanced_at: params[:report][:day].to_date)
    elsif params[:report][:month].present? && params[:report][:year].present?
      name_file = params[:report][:month].to_s + "_" + params[:report][:year].to_s
      @attendances = Attendance.where(student_id: @student.id)
                               .where("extract(month from attendanced_at) = ?", params[:report][:month].to_i)
                               .where("extract(year from attendanced_at) = ?", params[:report][:year].to_i)
    elsif params[:report][:year].present?
      name_file = params[:report][:year].to_s
      @attendances = Attendance.where(student_id: @student.id)
                              .where("extract(year from attendanced_at) = ?", params[:report][:year].to_i)
    end
    respond_to do |format|
      format.html
      format.csv { send_data @attendances.to_csv }
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"Attendance List #{@student.name} #{name_file}.xlsx\"" } 
    end
  end

  def export_by_grade
    @grade = Grade.find(params[:report][:grade_id].to_i)
    name_file = ""
    if params[:report][:day].present?
      name_file = params[:report][:day].to_s
      @attendances = Attendance.where('student_id IN (?)', @grade.students.map(&:id))
                               .where(attendanced_at: params[:report][:day].to_date)
    elsif params[:report][:month].present? && params[:report][:year].present?
      name_file = params[:report][:month].to_s + "_" + params[:report][:year].to_s
      @attendances = Attendance.where('student_id IN (?)', @grade.students.map(&:id))
                               .where("extract(month from attendanced_at) = ?", params[:report][:month].to_i)
                               .where("extract(year from attendanced_at) = ?", params[:report][:year].to_i)
    elsif params[:report][:year].present?
      name_file = params[:report][:year].to_s
      @attendances = Attendance.where('student_id IN (?)', @grade.students.map(&:id))
                              .where("extract(year from attendanced_at) = ?", params[:report][:year].to_i)
    end
    respond_to do |format|
      format.html
      format.csv { send_data @attendances.to_csv }
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"Attendance List #{@grade.name} #{name_file}.xlsx\"" } 
    end
  end

  def export_by_staff
    name_file = ""
    if params[:report][:day].present?
      name_file = params[:report][:day].to_s
      @attendances = Attendance.where('teacher_id IN (?)', User.all.map(&:id))
                               .where(attendanced_at: params[:report][:day].to_date)
    elsif params[:report][:month].present? && params[:report][:year].present?
      name_file = params[:report][:month].to_s + "_" + params[:report][:year].to_s
      @attendances = Attendance.where('teacher_id IN (?)', User.all.map(&:id))
                               .where("extract(month from attendanced_at) = ?", params[:report][:month].to_i)
                               .where("extract(year from attendanced_at) = ?", params[:report][:year].to_i)
    elsif params[:report][:year].present?
      name_file = params[:report][:year].to_s
      @attendances = Attendance.where('teacher_id IN (?)', User.all.map(&:id))
                              .where("extract(year from attendanced_at) = ?", params[:report][:year].to_i)
    end
    respond_to do |format|
      format.html
      format.csv { send_data @attendances.to_csv }
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"staff attendance list #{name_file}.xlsx\"" } 
    end
  end

  private
    def sort_column
      Student.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
