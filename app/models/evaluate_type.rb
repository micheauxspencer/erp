# == Schema Information
#
# Table name: evaluate_types
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  report_template_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_evaluate_types_on_report_template_id  (report_template_id)
#

class EvaluateType < ActiveRecord::Base
  has_many :evaluates
  belongs_to :report_template
end
