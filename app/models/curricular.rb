# == Schema Information
#
# Table name: curriculars
#
#  id               :integer          not null, primary key
#  student_id       :integer
#  content          :string(2000)
#  created_at       :datetime
#  updated_at       :datetime
#  acedemic_year_id :integer
#
# Indexes
#
#  index_curriculars_on_student_id  (student_id)
#

class Curricular < ActiveRecord::Base
  belongs_to :student
  belongs_to :acedemic_year

  def get_acedemic_year_id
    self.acedemic_year.present? ? self.acedemic_year.id : nil
  end

end
