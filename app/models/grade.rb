# == Schema Information
#
# Table name: grades
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  teacher_id         :integer
#  term_id            :integer
#  report_template_id :integer
#  acedemic_year_id   :integer
#
# Indexes
#
#  index_grades_on_term_id  (term_id)
#

class Grade < ActiveRecord::Base
	has_many :graduations, dependent: :restrict_with_exception
	has_many :students
	has_many :users
	belongs_to :acedemic_year

  belongs_to :teacher, :class_name => "User"

  belongs_to :term
  belongs_to :report_template

  has_many :grade_students
  has_many :students, through: :grade_students

  validates :name, presence: true
  validates :acedemic_year_id, presence: true

 	accepts_nested_attributes_for :graduations

  def get_id_report_template
    self.report_template.present? ? self.report_template.id : nil
  end

  def get_next_year
    acedemic_year = self.try(:acedemic_year)
    next_year = acedemic_year.try(:year).to_i + 1
    return AcedemicYear.where(year: next_year.to_s).try(:first)
  end

  def get_next_grades
    acedemic_year = self.try(:acedemic_year)
    next_year = acedemic_year.try(:year).to_i + 1
    acedemic_year_next = AcedemicYear.where(year: next_year.to_s).try(:first)
    return acedemic_year_next.grades
  end

  def name_year
    self.try(:name) + " - " + self.try(:acedemic_year).try(:year).to_s
  end
end
