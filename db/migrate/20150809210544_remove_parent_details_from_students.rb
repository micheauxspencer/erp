class RemoveParentDetailsFromStudents < ActiveRecord::Migration
  def change
    remove_column :students, :f_street, :string
    remove_column :students, :f_city, :string
    remove_column :students, :f_postal, :string
    remove_column :students, :m_street, :string
    remove_column :students, :m_city, :string
    remove_column :students, :m_postal, :string
  end
end
