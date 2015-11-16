# == Schema Information
#
# Table name: charges
#
#  id         :integer          not null, primary key
#  student_id :integer
#  fee_id     :integer
#  created_at :datetime
#  updated_at :datetime
#  term_id    :integer
#
# Indexes
#
#  index_charges_on_term_id  (term_id)
#

class Charge < ActiveRecord::Base
	belongs_to :student
	belongs_to :fee
  belongs_to :term
end
