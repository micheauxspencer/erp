# == Schema Information
#
# Table name: parents
#
#  id           :integer          not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  gender       :string(255)
#  birthdate    :date
#  phone        :string(255)
#  cell         :string(255)
#  work         :string(255)
#  email        :string(255)
#  home_address :string(255)
#  city         :string(255)
#  state        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Parent < ActiveRecord::Base
  has_many :student_parents
  has_many :students, through: :student_parents

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true

  def name
    return "#{first_name} #{last_name}"
  end

end
