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
#  transferred          :boolean          default(FALSE)
#  enrollment_year      :integer
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
	belongs_to :route

  has_many :student_siblings, :class_name => "StudentSibling"
  has_many :siblings, :through => :student_siblings, dependent: :destroy

  has_many :charges, dependent: :restrict_with_error
  has_many :fees, through: :charges

  has_many :term_students
  has_many :terms, through: :term_students

  has_many :grade_students
  has_many :grades, through: :grade_students

  has_many :student_parents
  has_many :parents, through: :student_parents

  has_many :attendances
  has_many :curriculars

  scope :not_siblings, -> (student) { where('id NOT IN (?)', student.siblings.map(&:id) << student.id)}
  scope :transferred, -> { where transferred: true}
  scope :not_transferred, -> { where transferred: false}

  scope :select_student_by_year, -> (acedemic_year) {
    joins(:grade_students).select('students.*').where("grade_students.grade_id IN (?)", acedemic_year.grades.map(&:id)).uniq
  }

  def grade_name
    grade.try(:name)
  end

  def grade
    return self.grades.last
  end

  def current_grade acedemic_year_id
    self.try(:grades).where(acedemic_year_id: acedemic_year_id).try(:first)
  end

  def get_grade_id
    self.grade.present? ? self.grade.id : nil
  end

  def name
    return "#{first_name} #{last_name}"
  end

  def full_name
    return "#{first_name} #{middle_name} #{last_name}"
  end

  def self.search_student (students, search)
    students = students.where("first_name LIKE ? or last_name LIKE ?",
      "%#{search}%", "%#{search}%") if search.present?
    students
  end

  def get_next_grade acedemic_year_id
    if acedemic_year_id.present?
      acedemic_year = AcedemicYear.where(id: acedemic_year_id).try(:first)
      grade_student = GradeStudent.where(student_id: self.id).where(grade_id: acedemic_year.try(:grades).map(&:id)).try(:first)
      return grade_student.try(:grade)
    else
      return nil
    end
  end

  def get_report_template
    if self.grade && self.grade.report_template
      self.grade.report_template
    else
      ReportTemplate.first
    end
  end

  def self.get_total_days_absent(student, acedemic_year)
    Attendance.where("student_id = ? and type_action = ? and term_id in (?)", student.id, "absence", acedemic_year.terms.map(&:id)).count
  end

  def self.get_total_times_late(student, acedemic_year)
    Attendance.where("student_id = ? and type_action = ? and term_id in (?)", student.id, "late", acedemic_year.terms.map(&:id)).count
  end

  def self.get_list_student (grade_id, search, year, enrollment_year)
    grade = grade_id && grade_id.to_i != 0 ? Grade.find(grade_id.to_i) : nil

    students_all = []
    if grade
      students_all = Student.search_student( grade.students.not_transferred, search)
    else
      students_all = Student.search_student( Student.not_transferred, search)
    end

    if year.present? && year.to_i !=  0
      acedemic_year = AcedemicYear.where(year: year.to_i).try(:first)
      students_all = students_all.select_student_by_year(acedemic_year)
    end

    if enrollment_year.present? && enrollment_year.to_i !=  0
      students_all = students_all.where(enrollment_year: enrollment_year.to_i)
    end

    return students_all
  end

  def self.name_file (grade_id, search, year, enrollment_year)
    grade = grade_id && grade_id.to_i != 0 ? Grade.find(grade_id.to_i) : nil
    name_file = ""
    name_file += " year_" + year.to_s if year.present? && year.to_i !=  0
    name_file += " grade_" + grade.try(:name) if grade.present?
    name_file += " enrollment_year_" + enrollment_year.to_s if enrollment_year.present? && enrollment_year.to_i != 0
    name_file += " search_" + search.to_s if search.present?
    return name_file
  end

  def self.import_csv(file)
    begin
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)

      arr_student_ids = Student.pluck(:id)

      students = []
      grade_students = []
      grades = {}
      parents = []
      student_parents = []
      student_id = nil
      parent_id = 1


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
          student_id = row["Student Number"].to_i
          students << Student.new(params)
        end

        if row["Parents relation"].present? && student_id.present?
          parent = Parent.new(
            id: parent_id,
            gender: row["Parents relation"].downcase == "mother" ? "Male" : "Female",
            first_name: row["Parents first name"],
            last_name: row["Parents last name"],
            home_address: row["Parents home address 1"],
            city: row["Parents city"],
            state: row["Parents state"],
            phone: row["Parents home phone"],
            work:  row["Parents mobile phone"]
          )
          parents << parent
          student_parents << StudentParent.new(student_id: student_id, parent_id: parent_id)
          parent_id += 1
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
      Parent.import(parents)
      StudentParent.import(student_parents)

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

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |student|
        csv << student.attributes.values_at(*column_names)
      end
    end
  end

end
