class CreateYearFees < ActiveRecord::Migration
  def change
    create_table :year_fees do |t|
      t.integer :acedemic_year_id
      t.integer :fee_id

      t.timestamps
    end
  end
end
