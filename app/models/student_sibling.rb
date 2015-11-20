# == Schema Information
#
# Table name: student_siblings
#
#  id         :integer          not null, primary key
#  student_id :integer
#  sibling_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class StudentSibling < ActiveRecord::Base
  belongs_to :student,  :class_name => "Student"
  belongs_to :sibling,  :class_name => 'Student'

  after_create :create_inverse, unless: :has_inverse?
  after_destroy :destroy_inverses, if: :has_inverse?

  def create_inverse
    self.class.create(inverse_student_sibling_options)
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def has_inverse?
    self.class.exists?(inverse_student_sibling_options)
  end

  def inverses
    self.class.where(inverse_student_sibling_options)
  end

  def inverse_student_sibling_options
    { sibling_id: student_id, student_id: sibling_id }
  end
end
