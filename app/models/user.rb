# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string(255)
#  user_name              :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  address                :string(255)
#  birth_date             :datetime
#  phone                  :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base

  ROLE = {
      teacher: 'teacher',
      office: 'office',
      assistant: 'assistant'
  }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:user_name]

  has_many :grades, foreign_key: :teacher_id

  validates :user_name, :presence => true, uniqueness: {
      :case_sensitive => false
  }

  validates :role, inclusion: ROLE.values

  scope :teachers, -> {where role: "teacher"}

  def role?(r)
    self.role && (self.role.include? r.to_s)
  end

  def name
    return self.first_name.to_s + ' ' + self.last_name.to_s
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if user_name = conditions.delete(:user_name)
      where(conditions.to_hash).where(["lower(user_name) = :value", { :value => user_name.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end
end
