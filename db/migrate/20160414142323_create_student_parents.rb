class CreateStudentParents < ActiveRecord::Migration
  def change
    create_table :student_parents do |t|
      t.references :student, index: true
      t.references :parent, index: true

      t.timestamps
    end
  end
end
