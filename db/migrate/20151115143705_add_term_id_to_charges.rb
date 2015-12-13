class AddTermIdToCharges < ActiveRecord::Migration
  def change
    add_reference :charges, :term, index: true
  end
end
