# == Schema Information
#
# Table name: students
#
#  id                   :integer          not null, primary key
#  first_name           :string(255)
#  last_name            :string(255)
#  sin                  :integer
#  birthdate            :date
#  trans_req            :boolean
#  tax_rec_req          :boolean
#  route_fee            :string(255)
#  pick_up              :boolean
#  drop_off             :boolean
#  sibling_id           :integer
#  f_first_name         :string(255)
#  f_last_name          :string(255)
#  f_province           :string(255)
#  f_phone              :string(255)
#  m_first_name         :string(255)
#  m_last_name          :string(255)
#  m_province           :string(255)
#  m_phone              :string(255)
#  email                :string(255)
#  emerg_1_name         :string(255)
#  emerg_1_phone        :string(255)
#  emerg_1_relation     :string(255)
#  emerg_2_name         :string(255)
#  emerg_2_phone        :string(255)
#  emerg_2_relation     :string(255)
#  healthcard           :string(255)
#  doctor_name          :string(255)
#  doctor_phone         :string(255)
#  enrolled             :boolean
#  created_at           :datetime
#  updated_at           :datetime
#  middle_name          :string(255)
#  last_shool_attended  :string(255)
#  last_school_phone    :string(255)
#  custody              :text
#  nearest_intersection :string(255)
#  health_notes         :text
#  street               :string(255)
#  city                 :string(255)
#  postal_code          :string(255)
#  gender               :string(255)
#  status               :string(255)
#  f_cell               :string(255)
#  m_cell               :string(255)
#  f_work               :string(255)
#  m_work               :string(255)
#  f_email              :string(255)
#  m_email              :string(255)
#  medical_conditions   :text
#  medicated            :boolean
#  medication           :string(255)
#  grade_id             :integer
#  route_id             :integer
#
# Indexes
#
#  index_students_on_grade_id  (grade_id)
#  index_students_on_route_id  (route_id)
#

class Student < ActiveRecord::Base
	has_many :enrollments
	has_many :acedemic_years, through: :enrollments
	belongs_to :acedemic_year

	# belongs_to :grade
	belongs_to :route

  has_many :student_siblings, :class_name => "StudentSibling"
  has_many :siblings, :through => :student_siblings, dependent: :destroy

  has_many :charges, dependent: :restrict_with_error
  has_many :fees, through: :charges

  has_many :term_students
  has_many :terms, through: :term_students

  has_many :grade_students
  has_many :grades, through: :grade_students

  scope :not_siblings, -> (student) { where('id NOT IN (?)', student.siblings.map(&:id) << student.id)}

  def grade_name
    grade.try(:name)
  end

  def grade
    return self.grades.last
  end

  def name
    return first_name + ' ' + last_name
  end
end
