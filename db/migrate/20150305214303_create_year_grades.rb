class CreateYearGrades < ActiveRecord::Migration
  def change
    create_table :year_grades do |t|
      t.integer :acedemic_year_id
      t.integer :grade_id
      t.datetime :created_at

      t.timestamps
    end
  end
end
