# == Schema Information
#
# Table name: reports
#
#  id            :integer          not null, primary key
#  type          :integer
#  category      :string(255)
#  indicator     :integer
#  teacher_id    :integer
#  class_name_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_reports_on_class_name_id  (class_name_id)
#

class Report < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User'
  belongs_to :class_name
end
