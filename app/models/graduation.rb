# == Schema Information
#
# Table name: graduations
#
#  id         :integer          not null, primary key
#  student_id :integer
#  grade_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Graduation < ActiveRecord::Base
	belongs_to :student
	belongs_to :grade
end
