class Route < ActiveRecord::Base

	has_many :year_routes, dependent: :restrict_with_error
	has_many :acedemic_years, through: :year_routes
	has_many :students

  accepts_nested_attributes_for :year_routes
end
