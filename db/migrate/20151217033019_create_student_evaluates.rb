class CreateStudentEvaluates < ActiveRecord::Migration
  def change
    create_table :student_evaluates do |t|
      t.references :term_student, index: true
      t.references :evaluate, index: true
      t.integer :mark

      t.timestamps
    end
  end
end