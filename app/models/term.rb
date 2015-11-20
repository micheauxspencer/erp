# == Schema Information
#
# Table name: terms
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  acedemic_year_id :integer
#

class Term < ActiveRecord::Base
  belongs_to :acedemic_year

  has_many :term_grades
  has_many :grades, through: :term_grades

  has_many :term_students
  has_many :students, through: :term_students


  validates :name, presence: true

end
