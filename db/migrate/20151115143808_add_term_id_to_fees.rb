class AddTermIdToFees < ActiveRecord::Migration
  def change
    add_reference :fees, :term, index: true
  end
end
