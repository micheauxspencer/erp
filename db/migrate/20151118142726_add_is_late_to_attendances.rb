class AddIsLateToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :is_late, :boolean, default: false
  end
end
