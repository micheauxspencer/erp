class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.boolean :absence
      t.integer :teacher_id
      t.references :class_name, index: true
      t.references :student, index: true

      t.timestamps
    end
  end
end
