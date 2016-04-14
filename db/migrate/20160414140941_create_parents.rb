class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :birthdate 
      t.string :phone
      t.string :cell
      t.string :work
      t.string :email
      t.string :home_address
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end