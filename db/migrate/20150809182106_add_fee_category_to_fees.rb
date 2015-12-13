class AddFeeCategoryToFees < ActiveRecord::Migration
  def change
    add_column :fees, :fee_caregory_id, :integer
  end
end
