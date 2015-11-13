class YearFee < ActiveRecord::Base
	belongs_to :fee 
	belongs_to :acedemic_year
end
