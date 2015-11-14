# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class Teacher < ActiveRecord::Base  
  belongs_to :user
  accepts_nested_attributes_for :user
end
