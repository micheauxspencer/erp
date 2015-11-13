class YearGrade < ActiveRecord::Base
	belongs_to :acedemic_year
	belongs_to :grade
end
