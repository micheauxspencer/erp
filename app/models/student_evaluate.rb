# == Schema Information
#
# Table name: student_evaluates
#
#  id              :integer          not null, primary key
#  term_student_id :integer
#  evaluate_id     :integer
#  mark            :integer
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_student_evaluates_on_evaluate_id      (evaluate_id)
#  index_student_evaluates_on_term_student_id  (term_student_id)
#

class StudentEvaluate < ActiveRecord::Base
  belongs_to :evaluate_type
  belongs_to :term_student

  def self.get_mark(evaluate_id, student_id, term_id)
    term_student = TermStudent.where(student_id: student_id, term_id: term_id).first
    if term_student.present?
      student_evaluate = StudentEvaluate.where(evaluate_id: evaluate_id, term_student_id: term_student.id).first
      if student_evaluate.present?
        return student_evaluate.mark
      end
    end
    return nil
  end
end
