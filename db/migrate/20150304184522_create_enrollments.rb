class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :acedemic_year_id
      t.integer :student_id
      t.datetime :created_at

      t.timestamps
    end
  end
end
