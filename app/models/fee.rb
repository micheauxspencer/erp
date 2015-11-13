class Fee < ActiveRecord::Base
	#has_many :year_fees
	#has_many :acedemic_years, through: :year_fees
 	#accepts_nested_attributes_for :year_fees

 	#belongs_to :fee_category

  has_many :charges, dependent: :restrict_with_error
  has_many :students, through: :charges
end
