# == Schema Information
#
# Table name: enrollments
#
#  id               :integer          not null, primary key
#  acedemic_year_id :integer
#  student_id       :integer
#  created_at       :datetime
#  updated_at       :datetime
#  term_id          :integer
#
# Indexes
#
#  index_enrollments_on_term_id  (term_id)
#

class Enrollment < ActiveRecord::Base
	belongs_to :acedemic_year
	belongs_to :student

  belongs_to :term

end
