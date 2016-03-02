# == Schema Information
#
# Table name: acedemic_years
#
#  id             :integer          not null, primary key
#  year           :integer
#  start_date     :date
#  end_date       :date
#  created_at     :datetime
#  updated_at     :datetime
#  curriculars_id :integer
#
# Indexes
#
#  index_acedemic_years_on_curriculars_id  (curriculars_id)
#

class AcedemicYear < ActiveRecord::Base

	has_many :year_grades, dependent: :restrict_with_error
	has_many :grades, through: :year_grades

	has_many :year_routes, dependent: :restrict_with_error
	has_many :routes, through: :year_routes

	has_many :year_fees, dependent: :restrict_with_error
	has_many :fees, through: :year_fees

  has_many :terms

  accepts_nested_attributes_for :year_grades, :year_fees, :year_routes

end
