# == Schema Information
#
# Table name: class_names
#
#  id         :integer          not null, primary key
#  grade_id   :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  teacher_id :integer
#
# Indexes
#
#  index_class_names_on_grade_id  (grade_id)
#

class ClassName < ActiveRecord::Base
  belongs_to :grade

  belongs_to :teacher, :class_name => "User"

  validates :name, presence: true

  has_many :term_classes
  has_many :terms, through: :term_classes

  has_many :students
end
