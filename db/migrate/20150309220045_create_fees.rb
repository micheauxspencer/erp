class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.string :name
      t.float :amount

      t.timestamps
    end
  end
end
