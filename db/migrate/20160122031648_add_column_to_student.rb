class AddColumnToStudent < ActiveRecord::Migration
  def change
    add_column :students, :f_home_address, :string
    add_column :students, :f_city, :string
    add_column :students, :f_state, :string

    add_column :students, :m_home_address, :string
    add_column :students, :m_city, :string
    add_column :students, :m_state, :string

    add_column :students, :phone, :string
    add_column :students, :mobile, :string
  end
end