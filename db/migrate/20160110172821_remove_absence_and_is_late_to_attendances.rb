class RemoveAbsenceAndIsLateToAttendances < ActiveRecord::Migration
  def change
    remove_column :attendances, :absence
    remove_column :attendances, :is_late
  end
end
