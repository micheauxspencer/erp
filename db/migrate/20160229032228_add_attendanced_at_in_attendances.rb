class AddAttendancedAtInAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :attendanced_at, :date
  end
end
