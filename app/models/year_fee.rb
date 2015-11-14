# == Schema Information
#
# Table name: year_fees
#
#  id               :integer          not null, primary key
#  acedemic_year_id :integer
#  fee_id           :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class YearFee < ActiveRecord::Base
	belongs_to :fee 
	belongs_to :acedemic_year
end
