class Enrollment < ActiveRecord::Base
	belongs_to :acedemic_year
	belongs_to :student
end
