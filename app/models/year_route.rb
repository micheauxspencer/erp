# == Schema Information
#
# Table name: year_routes
#
#  id               :integer          not null, primary key
#  acedemic_year_id :integer
#  route_id         :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class YearRoute < ActiveRecord::Base
	belongs_to :route 
	belongs_to :acedemic_year
end
