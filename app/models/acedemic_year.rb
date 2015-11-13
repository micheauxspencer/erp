class AcedemicYear < ActiveRecord::Base
	has_many :year_grades, dependent: :restrict_with_error
	has_many :grades, through: :year_grades

	has_many :year_routes, dependent: :restrict_with_error
	has_many :routes, through: :year_routes

	has_many :year_fees, dependent: :restrict_with_error
	has_many :fees, through: :year_fees



  accepts_nested_attributes_for :year_grades, :year_fees, :year_routes

end
