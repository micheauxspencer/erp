class CreateAcedemicYears < ActiveRecord::Migration
  def change
    create_table :acedemic_years do |t|
      t.integer :year
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
