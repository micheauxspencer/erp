class AddColunmToStudents < ActiveRecord::Migration
  def change
    add_column :students, :state, :string
    add_column :students, :nationality, :string
    add_column :students, :category, :string
    add_column :students, :country, :string
    add_column :students, :immediate_contact, :string
    add_column :students, :biometric, :string
  end
end
