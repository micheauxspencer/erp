class CreateAcedemicYearGrades < ActiveRecord::Migration
  def change
    create_table :acedemic_year_grades do |t|
      t.integer :acedemic_year_id
      t.integer :grade_id

      t.timestamps
    end
  end
end
