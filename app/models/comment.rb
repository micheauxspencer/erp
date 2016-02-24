# == Schema Information
#
# Table name: comments
#
#  id              :integer          not null, primary key
#  term_student_id :integer
#  content         :string(2000)
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_comments_on_term_student_id  (term_student_id)
#

class Comment < ActiveRecord::Base
  belongs_to :term_student

  def self.get_comment(student_id, term_id)
    term_student = TermStudent.find_by(student_id: student_id, term_id: term_id)
    return nil unless term_student.present?
    comment = Comment.find_by(term_student_id: term_student.id)
    return comment.present? ? comment.content : nil
  end
end
