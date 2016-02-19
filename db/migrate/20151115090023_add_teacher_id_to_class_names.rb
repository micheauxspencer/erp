class AddTeacherIdToClassNames < ActiveRecord::Migration
  def change
    add_column :class_names, :teacher_id, :integer
  end
end
