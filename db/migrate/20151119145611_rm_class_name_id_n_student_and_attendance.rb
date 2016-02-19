class RmClassNameIdNStudentAndAttendance < ActiveRecord::Migration
  def change
    remove_column :students, :class_name_id
    remove_column :attendances, :class_name_id
    add_column :attendances, :grade_id, :integer, index: true
  end
end
