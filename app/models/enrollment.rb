# == Schema Information
#
# Table name: enrollments
#
#  id               :integer          not null, primary key
#  acedemic_year_id :integer
#  student_id       :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Enrollment < ActiveRecord::Base
	belongs_to :acedemic_year
	belongs_to :student
end
