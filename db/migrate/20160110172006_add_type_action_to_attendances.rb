class AddTypeActionToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :type_action, :string
  end
end
