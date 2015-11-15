# == Schema Information
#
# Table name: term_classes
#
#  id            :integer          not null, primary key
#  class_name_id :integer
#  term_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_term_classes_on_class_name_id  (class_name_id)
#  index_term_classes_on_term_id        (term_id)
#

class TermClass < ActiveRecord::Base
  belongs_to :class_name
  belongs_to :term
end
