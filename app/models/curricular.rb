# == Schema Information
#
# Table name: curriculars
#
#  id         :integer          not null, primary key
#  student_id :integer
#  content    :string(2000)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_curriculars_on_student_id  (student_id)
#

class Curricular < ActiveRecord::Base
  belongs_to :student
end
