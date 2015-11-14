class ClassName < ActiveRecord::Base
  belongs_to :grade

  validates :name, presence: true

  has_many :term_classes
  has_many :terms, through: :term_classes

  has_many :students
end
