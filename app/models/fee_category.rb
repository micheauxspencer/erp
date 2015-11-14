# == Schema Information
#
# Table name: fee_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class FeeCategory < ActiveRecord::Base
end
