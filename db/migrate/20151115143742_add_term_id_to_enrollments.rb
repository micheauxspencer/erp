class AddTermIdToEnrollments < ActiveRecord::Migration
  def change
    add_reference :enrollments, :term, index: true
  end
end
