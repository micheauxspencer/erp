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

  def mark1_4?
    evaluate = self.evaluates.first
    return false unless evaluate.present?
    return evaluate.mark_type == Evaluate::MARK_TYPE[:mark1_4] ? true : false
  end

  def mark_100?
    evaluate = self.evaluates.first
    return false unless evaluate.present?
    return evaluate.mark_type == Evaluate::MARK_TYPE[:mark_100] ? true : false
  end

end
