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
#  state                :string(255)
#  nationality          :string(255)
#  category             :string(255)
#  country              :string(255)
#  immediate_contact    :string(255)
#  biometric            :string(255)
#  admission_date       :datetime
#  f_home_address       :string(255)
#  f_city               :string(255)
#  f_state              :string(255)
#  m_home_address       :string(255)
#  m_city               :string(255)
#  m_state              :string(255)
#  phone                :string(255)
#  mobile               :string(255)
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

  def get_grade_id
    self.grade.present? ? self.grade.id : nil
  end

  def name
    return "#{first_name} #{last_name}"
  end

  def get_report_template
    if self.grade && self.grade.report_template
      self.grade.report_template
    else
      ReportTemplate.first
    end
  end

  def self.import_csv(file)
    begin
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)

      arr_student_ids = Student.pluck(:id)

      students = []
      grade_students = []
      grades = {}

      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]

        if row["Student Number"].present?
          next if arr_student_ids.include? row["Student Number"]
          params = {
            id: row["Student Number"],
            admission_date: row["Admission Date"],
            birthdate: row["Date of Birth"],
            first_name: row["First Name"],
            last_name: row["Last Name"],
            middle_name: row["Middle Name"],
            gender: row["Gender"] == "m" ? "Male" : "Female",
            street: row["Address Line 1"],
            city: row["City"],
            state: row["State"],
            postal_code: row["Postal Code"],
            phone: row["Phone"],
            mobile: row["Mobile"],
            enrolled: true
          }

          if row["Parents relation"].present?
            if row["Parents relation"].downcase == "father"
              params.merge!(
                f_first_name: row["Parents first name"],
                f_last_name: row["Parents last name"],
                f_home_address: row["Parents home address 1"],
                f_city: row["Parents city"],
                f_state: row["Parents state"],
                f_phone: row["Parents home phone"],
                f_work:  row["Parents mobile phone"]
              )
            elsif row["Parents relation"].downcase == "mother"
              params.merge!(
                m_first_name: row["Parents first name"],
                m_last_name: row["Parents last name"],
                m_home_address: row["Parents home address 1"],
                m_city: row["Parents city"],
                m_state: row["Parents state"],
                m_phone: row["Parents home phone"],
                m_work:  row["Parents mobile phone"]
              )
            end
          end
          students << Student.new(params)
        else
          next unless Hash[[header, spreadsheet.row(i-1)].transpose]["Student Number"].present? && !arr_student_ids.include?(Hash[[header, spreadsheet.row(i-1)].transpose]["Student Number"].to_i)
          if row["Parents relation"].present?
            if row["Parents relation"].downcase == "father"
              students.last.f_first_name = row["Parents first name"]
              students.last.f_last_name = row["Parents last name"]
              students.last.f_home_address = row["Parents home address 1"]
              students.last.f_city = row["Parents city"]
              students.last.f_state = row["Parents state"]
              students.last.f_phone = row["Parents home phone"]
              students.last.f_work =  row["Parents mobile phone"]
            elsif row["Parents relation"].downcase == "mother"
              students.last.m_first_name = row["Parents first name"]
              students.last.m_last_name = row["Parents last name"]
              students.last.m_home_address = row["Parents home address 1"]
              students.last.m_city = row["Parents city"]
              students.last.m_state = row["Parents state"]
              students.last.m_phone = row["Parents home phone"]
              students.last.m_work = row["Parents mobile phone"]
            end
          end
        end

        if row["Grade"]
          unless grades[row["Grade"].to_s]
            grade = Grade.find_or_create_by(name: row["Grade"].to_s)
            grades[row["Grade"].to_s] = grade.id
          end

          grade_students << GradeStudent.new(student_id: row["Student Number"].to_i, grade_id: grades[row["Grade"].to_s])
        end

      end # end student loops

      Student.import(students)
      GradeStudent.import(grade_students)

      return true
    rescue => e
      logger.warn e
      return false
    end

  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, packed: nil, file_warning: :ignore)
    when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

end
