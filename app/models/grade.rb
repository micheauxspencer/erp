# == Schema Information
#
# Table name: grades
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Grade < ActiveRecord::Base
	has_many :graduations, dependent: :restrict_with_exception
	has_many :students
	has_many :users
	has_many :year_grades, dependent: :restrict_with_exception
	has_many :acedemic_years, through: :year_grades
 	accepts_nested_attributes_for :year_grades, :graduations
end
