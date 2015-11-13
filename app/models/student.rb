class Student < ActiveRecord::Base
	has_many :enrollments
	has_many :acedemic_years, through: :enrollments
	belongs_to :acedemic_year

	belongs_to :grade
	belongs_to :route


  has_many :student_siblings, :foreign_key => "student_id", :class_name => "StudentSibling"
  has_many :siblings, :through => :student_siblings, dependent: :destroy

  has_many :charges, dependent: :restrict_with_error
  has_many :fees, through: :charges

  accepts_nested_attributes_for :acedemic_years, :enrollments, :grade, :charges, :route

 #has_many :siblings, :class_name => "Student",
 #  :foreign_key => "sibling_id"
 #belongs_to :sibling, :class_name => "Student",
 #  :foreign_key => "sibling_id"

#has_many :student_siblings
#has_many :siblings, :through => :student_siblings
#has_many :inverse_student_siblings, :class_name => "StudentSibling", :foreign_key => "sibling_id"
#has_many :inverse_siblings, :through => :inverse_student_siblings, :source => :student
  

  #validates :first_name, :last_name, :sin, :birthdate, :email, :healthcard, :doctor_name, :doctor_phone, presence: true
  #validates :email, :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ , :message => 'Invalid e-mail! Please provide a valid e-mail address'}
 
end
