# == Schema Information
#
# Table name: terms
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  acedemic_year_id :integer
#  start_date       :date
#  end_date         :date
#

class Term < ActiveRecord::Base
  belongs_to :acedemic_year

  has_many :grades

  has_many :term_students
  has_many :students, through: :term_students


  validates :name, presence: true

  def get_acedemic_year_id
    self.acedemic_year.present? ? self.acedemic_year.id : nil
  end

end
