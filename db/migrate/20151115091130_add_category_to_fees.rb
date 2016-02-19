class AddCategoryToFees < ActiveRecord::Migration
  def change
    add_column :fees, :category, :string
  end
end
