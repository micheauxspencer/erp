class Graduation < ActiveRecord::Base
	belongs_to :student
	belongs_to :grade
end
