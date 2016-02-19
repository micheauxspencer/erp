class AddTermIdToAttendances < ActiveRecord::Migration
  def change
    add_reference :attendances, :term, index: true
  end
end
