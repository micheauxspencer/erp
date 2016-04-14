# == Schema Information
#
# Table name: student_parents
#
#  id         :integer          not null, primary key
#  student_id :integer
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_student_parents_on_parent_id   (parent_id)
#  index_student_parents_on_student_id  (student_id)
#

class StudentParent < ActiveRecord::Base
  belongs_to :student
  belongs_to :parent
end
