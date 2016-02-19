# == Schema Information
#
# Table name: grade_students
#
#  id         :integer          not null, primary key
#  grade_id   :integer
#  student_id :integer
#
# Indexes
#
#  index_grade_students_on_grade_id    (grade_id)
#  index_grade_students_on_student_id  (student_id)
#

class GradeStudent < ActiveRecord::Base
  belongs_to :grade
  belongs_to :student
end
