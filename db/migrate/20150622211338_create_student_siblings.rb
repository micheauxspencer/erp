class CreateStudentSiblings < ActiveRecord::Migration
  def change
    create_table :student_siblings do |t|
      t.integer :student_id
      t.integer :sibling_id

      t.timestamps
    end
  end
end
