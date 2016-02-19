class ChangeClassNameToGradeForReport < ActiveRecord::Migration
  def change
    remove_column :reports, :class_name_id
    add_column :reports, :grade_id, :integer, index: true
  end
end
