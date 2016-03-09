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
#  status           :string(255)      default("Inactive")
#

class Term < ActiveRecord::Base
  belongs_to :acedemic_year

  has_many :grades

  has_many :term_students
  has_many :students, through: :term_students

  validates :name, presence: true

  STATUSES = { :active => "Active", :inactive => "Inactive" }

  def get_acedemic_year_id
    self.acedemic_year.present? ? self.acedemic_year.id : nil
  end

  def active?
    self.status == "Active"
  end

end
