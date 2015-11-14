# == Schema Information
#
# Table name: year_grades
#
#  id               :integer          not null, primary key
#  acedemic_year_id :integer
#  grade_id         :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class YearGrade < ActiveRecord::Base
	belongs_to :acedemic_year
	belongs_to :grade
end
