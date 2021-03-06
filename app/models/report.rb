# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  type       :integer
#  category   :string(255)
#  indicator  :integer
#  teacher_id :integer
#  created_at :datetime
#  updated_at :datetime
#  term_id    :integer
#  grade_id   :integer
#
# Indexes
#
#  index_reports_on_term_id  (term_id)
#

class Report < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User'
  belongs_to :grade

  belongs_to :term_id
end
