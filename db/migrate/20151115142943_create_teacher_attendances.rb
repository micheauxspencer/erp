class CreateTeacherAttendances < ActiveRecord::Migration
  def change
    create_table :teacher_attendances do |t|
      t.integer :teacher_id
      t.integer :work_status

      t.timestamps
    end
  end
end
