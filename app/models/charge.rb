# == Schema Information
#
# Table name: charges
#
#  id         :integer          not null, primary key
#  student_id :integer
#  fee_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Charge < ActiveRecord::Base
	belongs_to :student
	belongs_to :fee
end
