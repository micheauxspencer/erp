class CreateGradeStudents < ActiveRecord::Migration
  def change
    create_table :grade_students do |t|
      t.references :grade, index: true
      t.references :student, index: true
    end
  end
end
