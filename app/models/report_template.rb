# == Schema Information
#
# Table name: report_templates
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ReportTemplate < ActiveRecord::Base
  has_many :grades
  has_many :evaluate_types
  has_many :evaluates

  NAME = ['js_jk', 'g1_g3', 'g4_g6', 'g7_g8']

end
