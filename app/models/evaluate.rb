# == Schema Information
#
# Table name: evaluates
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  evaluate_type_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_evaluates_on_evaluate_type_id  (evaluate_type_id)
#

class Evaluate < ActiveRecord::Base
  belongs_to :evaluate_type
  has_many :student_evaluates
end
