class CreateFeeCategories < ActiveRecord::Migration
  def change
    create_table :fee_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
