# == Schema Information
#
# Table name: fees
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  amount          :float
#  created_at      :datetime
#  updated_at      :datetime
#  fee_caregory_id :integer
#  category        :string(255)
#  term_id         :integer
#
# Indexes
#
#  index_fees_on_term_id  (term_id)
#

class Fee < ActiveRecord::Base

  has_many :charges, dependent: :restrict_with_error
  has_many :students, through: :charges

  belongs_to :term
end
