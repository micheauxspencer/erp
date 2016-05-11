# == Schema Information
#
# Table name: fees
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  amount          :float(24)
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

  validates :term, presence: true

  def self.get_fees_paid(student_id)
    select('fees.*').
      joins(:charges).
      group('fees.id').
      where('charges.student_id = ? and charges.is_completed = ?', student_id, true)
  end

  def self.get_fees_unpaid(student_id)
    select('fees.*').
      joins(:charges).
      group('fees.id').
      where('charges.student_id = ? and charges.is_completed = ?', student_id, false)
  end
end
