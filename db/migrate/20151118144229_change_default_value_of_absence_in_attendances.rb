class ChangeDefaultValueOfAbsenceInAttendances < ActiveRecord::Migration
  def change
    change_column :attendances, :absence, :boolean, :default => false
  end
end
