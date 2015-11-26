# == Schema Information
#
# Table name: grades
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  teacher_id :integer
#  term_id    :integer
#
# Indexes
#
#  index_grades_on_term_id  (term_id)
#

class Grade < ActiveRecord::Base
	has_many :graduations, dependent: :restrict_with_exception
	has_many :students
	has_many :users
	has_many :year_grades, dependent: :restrict_with_exception
	has_many :acedemic_years, through: :year_grades

  belongs_to :teacher, :class_name => "User"

  belongs_to :term

  has_many :grade_students
  has_many :students, through: :grade_students

  validates :name, presence: true

 	accepts_nested_attributes_for :year_grades, :graduations
end
