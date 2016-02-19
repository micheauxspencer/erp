# == Schema Information
#
# Table name: acedemic_year_grades
#
#  id               :integer          not null, primary key
#  acedemic_year_id :integer
#  grade_id         :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class AcedemicYearGrades < ActiveRecord::Base
end
