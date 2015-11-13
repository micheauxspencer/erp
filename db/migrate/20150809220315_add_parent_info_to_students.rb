class AddParentInfoToStudents < ActiveRecord::Migration
  def change
    add_column :students, :f_cell, :string
    add_column :students, :m_cell, :string
    add_column :students, :f_work, :string
    add_column :students, :m_work, :string
    add_column :students, :f_email, :string
    add_column :students, :m_email, :string
  end
end
