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
#  c_first_name         :string(255)
#  c_last_name          :string(255)
#  c_relation           :string(255)
#  c_office_address     :string(255)
#  c_city               :string(255)
#  c_state              :string(255)
#  c_office_phone       :string(255)
#  c_mobile_phone       :string(255)
#  f_office_address     :string(255)
#  f_city               :string(255)
#  f_state              :string(255)
#  m_office_address     :string(255)
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

  def name
    return first_name + ' ' + last_name
  end

  def self.import(file)
    import_total = 0
    import_success = 0
    begin
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      import_total = spreadsheet.last_row - 1
      student = Student.new
      (2..spreadsheet.last_row).each do |i|
        begin
          row = Hash[[header, spreadsheet.row(i)].transpose]
          term = Term.find_or_create_by(name: row["Batch"]) if row["Batch"] != nil

          if row["Sl. no."].present? && row["Sl. no."].to_s.gsub(' ', '') != ""
            student = Student.new(
              admission_date: row["Admission Date"],
              birthdate: row["Date of Birth"],
              first_name: row["First Name"],
              last_name: row["Last Name"],
              middle_name: row["Middle Name"],
              gender: row["Gender"] == "f" ? "Male" : "Female",
              street: row["Address Line 1"],
              city: row["City"],
              state: row["State"],
              postal_code: row["Pin code"],
              country: row["Country"],
              phone: row["Phone"],
              mobile: row["Mobile"],

              c_first_name: row["Immediate contact first name"],
              c_last_name: row["Immediate contact last name"],
              c_relation: row["Immediate contact relation"],
              c_office_address: row["Immediate contact office address 1"],
              c_city: row["Immediate contact city"],
              c_state: row["Immediate contact state"],
              c_office_phone: row["Immediate contact office phone"],
              c_mobile_phone: row["Immediate contact mobile phone"],

              f_first_name: row["Parents relation"] = "father" ? row["Parents first name"] : nil,
              f_last_name: row["Parents relation"] = "father" ? row["Parents last name"] : nil,
              f_office_address: row["Parents relation"] = "father" ? row["Parents office address 1"] : nil,
              f_city: row["Parents relation"] = "father" ? row["Parents city"] : nil,
              f_state: row["Parents relation"] = "father" ? row["Parents state"] : nil,
              f_phone: row["Parents relation"] = "father" ? row["Parents office phone"] : nil,
              f_work:  row["Parents relation"] = "father" ? row["Parents mobile phone"] : nil,

              m_first_name: row["Parents relation"] = "mother" ? row["Parents first name"] : nil,
              m_last_name: row["Parents relation"] = "mother" ? row["Parents last name"] : nil,
              m_office_address: row["Parents relation"] = "mother" ? row["Parents office address 1"] : nil,
              m_city: row["Parents relation"] = "mother" ? row["Parents city"] : nil,
              m_state: row["Parents relation"] = "mother" ? row["Parents state"] : nil,
              m_phone: row["Parents relation"] = "mother" ? row["Parents office phone"] : nil,
              m_work:  row["Parents relation"] = "mother" ? row["Parents mobile phone"] : nil,

              category: row["Student category"]
            )
            if student.valid? && student.save!
              TermStudent.create(student: student, term: term) if term.present?
              import_success = import_success + 1
            end
            student = student
          else
            if row["Parents relation"].present?
              student.update_attributes(
                f_first_name: row["Parents relation"] = "father" ? row["Parents first name"] : nil,
                f_last_name: row["Parents relation"] = "father" ? row["Parents last name"] : nil,
                f_office_address: row["Parents relation"] = "father" ? row["Parents office address 1"] : nil,
                f_city: row["Parents relation"] = "father" ? row["Parents city"] : nil,
                f_state: row["Parents relation"] = "father" ? row["Parents state"] : nil,
                f_phone: row["Parents relation"] = "father" ? row["Parents office phone"] : nil,
                f_work:  row["Parents relation"] = "father" ? row["Parents mobile phone"] : nil,

                m_first_name: row["Parents relation"] = "mother" ? row["Parents first name"] : nil,
                m_last_name: row["Parents relation"] = "mother" ? row["Parents last name"] : nil,
                m_office_address: row["Parents relation"] = "mother" ? row["Parents office address 1"] : nil,
                m_city: row["Parents relation"] = "mother" ? row["Parents city"] : nil,
                m_state: row["Parents relation"] = "mother" ? row["Parents state"] : nil,
                m_phone: row["Parents relation"] = "mother" ? row["Parents office phone"] : nil,
                m_work:  row["Parents relation"] = "mother" ? row["Parents mobile phone"] : nil
              )
            end
          end
        rescue
        end
      end
    rescue
    end
    return [import_success, import_total - import_success]
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
