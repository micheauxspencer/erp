# == Schema Information
#
# Table name: teacher_attendances
#
#  id          :integer          not null, primary key
#  teacher_id  :integer
#  work_status :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class TeacherAttendance < ActiveRecord::Base
  WORK_STATUS = {
      :late => 0,
      :absence => 1,
      :on_time => 2
  }

  belongs_to :teacher, class_name: 'User'
  
  #   work_status: 0 or 1 or 2
end
