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

  NAME = ['js_jk', 'g1_g3', 'g4_g6', 'g7_g8']

  TEAMPLATE_NAME = {
    grade_jsjk: 'js_jk',
    grade_13: 'g1_g3',
    grade_46: 'g4_g6',
    grade_78: 'g7_g8'
  }

end
