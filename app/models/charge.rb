class Charge < ActiveRecord::Base
	belongs_to :student
	belongs_to :fee
end
