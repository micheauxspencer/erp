class CreateTermStudents < ActiveRecord::Migration
  def change
    create_table :term_students do |t|
      t.references :term, index: true
      t.references :student, index: true

      t.timestamps
    end
  end
end
