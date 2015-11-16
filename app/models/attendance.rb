# == Schema Information
#
# Table name: attendances
#
#  id            :integer          not null, primary key
#  absence       :boolean
#  teacher_id    :integer
#  class_name_id :integer
#  student_id    :integer
#  created_at    :datetime
#  updated_at    :datetime
#  term_id       :integer
#
# Indexes
#
#  index_attendances_on_class_name_id  (class_name_id)
#  index_attendances_on_student_id     (student_id)
#  index_attendances_on_term_id        (term_id)
#

class Attendance < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User'
  belongs_to :class_name
  belongs_to :student

  belongs_to :term

  validate :absence, presence: true
end
