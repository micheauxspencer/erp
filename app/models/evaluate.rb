# == Schema Information
#
# Table name: evaluates
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  evaluate_type_id   :integer
#  created_at         :datetime
#  updated_at         :datetime
#  report_template_id :integer
#  mark_type          :integer
#
# Indexes
#
#  index_evaluates_on_evaluate_type_id    (evaluate_type_id)
#  index_evaluates_on_report_template_id  (report_template_id)
#

class Evaluate < ActiveRecord::Base
  belongs_to :evaluate_type
  has_many :student_evaluates
  belongs_to :report_template

  MARK_TYPE = { mark1_4: 0, mark_100: 1, mark_yes_no: 2 }

end
