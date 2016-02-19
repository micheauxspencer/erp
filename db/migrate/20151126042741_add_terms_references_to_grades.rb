class AddTermsReferencesToGrades < ActiveRecord::Migration
  def change
    add_reference :grades, :term, index: true
  end
end
