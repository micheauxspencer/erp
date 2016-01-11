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
#  avg             :integer
#
# Indexes
#
#  index_student_evaluates_on_evaluate_id      (evaluate_id)
#  index_student_evaluates_on_term_student_id  (term_student_id)
#

class StudentEvaluate < ActiveRecord::Base
  belongs_to :evaluate_type
  belongs_to :term_student

  def self.get_value(evaluate_id, student_id, term_id, type)
    term_student = TermStudent.find_by(student_id: student_id, term_id: term_id)
    return nil unless term_student.present?
    student_evaluate = StudentEvaluate.find_by(evaluate_id: evaluate_id, term_student_id: term_student.id)
    if student_evaluate.present?
      if type == "mark"
        return student_evaluate.mark
      elsif type == "avg"
        return student_evaluate.avg
      end
    else
      return nil
    end
  end

end
