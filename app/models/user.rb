class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:user_name]
  belongs_to :grade
  has_one :teacher

  validates :user_name, :presence => true, uniqueness: {
      :case_sensitive => false
  }

  ROLE = {
      teacher: 'teacher',
      office: 'office',
      assistant: 'assistant'
  }

  def role?(r)
    self.role && (self.role.include? r.to_s)
  end

  def name
    return self.first_name + ' ' + self.last_name
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
