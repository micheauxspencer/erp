# == Schema Information
#
# Table name: routes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  details    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  status     :boolean
#

class Route < ActiveRecord::Base

	has_many :year_routes, dependent: :restrict_with_error
	has_many :acedemic_years, through: :year_routes
	has_many :students

  accepts_nested_attributes_for :year_routes
end
