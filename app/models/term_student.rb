# == Schema Information
#
# Table name: term_students
#
#  id         :integer          not null, primary key
#  term_id    :integer
#  student_id :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_term_students_on_student_id  (student_id)
#  index_term_students_on_term_id     (term_id)
#

class TermStudent < ActiveRecord::Base
  belongs_to :term
  belongs_to :student
  has_many :student_evaluates
end
