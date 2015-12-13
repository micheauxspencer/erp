class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :student_id
      t.integer :fee_id

      t.timestamps
    end
  end
end
