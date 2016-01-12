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
      (2..spreadsheet.last_row).each do |i|
        begin
          row = Hash[[header, spreadsheet.row(i)].transpose]
          student =  Student.new(
            first_name: row["Student name"].split(" ")[0..-2].join(" "),
            last_name: row["Student name"].split(" ").last,
            birthdate: row["Date of birth"],
            gender: row["Gender"] == "f" ? "Male" : "Female",
            nationality: row["Nationality"],
            category: row["Category"],
            street: row["Address"],
            city: row["City"],
            state: row["State"],
            postal_code: row["Pin code"],
            country: row["Country"],
            f_phone: row["Phone"],
            m_phone: row["Mobile"],
            immediate_contact: row["Immediate contact"],
            biometric: row["Biometric"]
            # : row["All siblings"]
          )
          if student.valid? && student.save!
            import_success = import_success + 1
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
