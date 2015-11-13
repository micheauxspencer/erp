class AddAddressToStudents < ActiveRecord::Migration
  def change
    add_column :students, :street, :string
    add_column :students, :city, :string
    add_column :students, :postal_code, :string
  end
end
