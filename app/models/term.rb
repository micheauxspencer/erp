# == Schema Information
#
# Table name: terms
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  academic_year_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_terms_on_academic_year_id  (academic_year_id)
#

class Term < ActiveRecord::Base
  belongs_to :academic_year

  has_many :term_grades
  has_many :grades, through: :term_grades

  has_many :term_classes
  has_many :class_names, through: :term_classes

  validates :name, presence: true

end
