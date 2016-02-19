class AddFieldsToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :amount, :integer
    add_column :charges, :is_completed, :boolean, default: false
  end
end
