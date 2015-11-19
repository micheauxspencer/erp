# == Schema Information
#
# Table name: attendances
#
#  id         :integer          not null, primary key
#  absence    :boolean          default(FALSE)
#  teacher_id :integer
#  student_id :integer
#  created_at :datetime
#  updated_at :datetime
#  term_id    :integer
#  is_late    :boolean          default(FALSE)
#  grade_id   :integer
#
# Indexes
#
#  index_attendances_on_student_id  (student_id)
#  index_attendances_on_term_id     (term_id)
#

class Attendance < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User'
  belongs_to :grade
  belongs_to :student

  belongs_to :term

  validates :student_id, presence: true
end
