# == Schema Information
#
# Table name: acedemic_years
#
#  id         :integer          not null, primary key
#  year       :integer
#  start_date :date
#  end_date   :date
#  created_at :datetime
#  updated_at :datetime
#

class AcedemicYear < ActiveRecord::Base
  
	has_many :grades, :dependent => :destroy

	has_many :year_routes, dependent: :restrict_with_error
	has_many :routes, through: :year_routes

	has_many :year_fees, dependent: :restrict_with_error
	has_many :fees, through: :year_fees

  has_many :terms, :dependent => :destroy

  accepts_nested_attributes_for :year_fees, :year_routes

  def self.next_acedemic_year acedemic_year
    if acedemic_year.present?
      next_year =  acedemic_year.try(:year).to_i + 1
      return AcedemicYear.where(year: next_year.to_s).try(:first)
    else
      return nil
    end
  end

end
