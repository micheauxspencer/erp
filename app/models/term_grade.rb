# == Schema Information
#
# Table name: term_grades
#
#  id         :integer          not null, primary key
#  term_id    :integer
#  grade_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_term_grades_on_grade_id  (grade_id)
#  index_term_grades_on_term_id   (term_id)
#

class TermGrade < ActiveRecord::Base
  belongs_to :term
  belongs_to :grade
end
