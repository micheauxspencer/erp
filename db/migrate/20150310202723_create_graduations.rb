class CreateGraduations < ActiveRecord::Migration
  def change
    create_table :graduations do |t|
      t.integer :student_id
      t.integer :grade_id

      t.timestamps
    end
  end
end
