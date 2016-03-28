# == Schema Information
#
# Table name: attendances
#
#  id             :integer          not null, primary key
#  teacher_id     :integer
#  student_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#  term_id        :integer
#  grade_id       :integer
#  type_action    :string(255)
#  attendanced_at :date
#
# Indexes
#
#  index_attendances_on_student_id  (student_id)
#  index_attendances_on_term_id     (term_id)
#

class Attendance < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User'
  belongs_to :grade
  belongs_to :student

  belongs_to :term

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |attendance|
        csv << attendance.attributes.values_at(*column_names)
      end
    end
  end

end
