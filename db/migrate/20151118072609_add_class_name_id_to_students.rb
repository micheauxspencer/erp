class AddClassNameIdToStudents < ActiveRecord::Migration
  def change
    add_column :students, :class_name_id, :integer
  end
end
