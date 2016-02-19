class CreateTermGrades < ActiveRecord::Migration
  def change
    create_table :term_grades do |t|
      t.references :term, index: true
      t.references :grade, index: true

      t.timestamps
    end
  end
end
