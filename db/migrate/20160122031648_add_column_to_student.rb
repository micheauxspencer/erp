class AddColumnToStudent < ActiveRecord::Migration
  def change
    add_column :students, :c_first_name, :string
    add_column :students, :c_last_name, :string
    add_column :students, :c_relation, :string
    add_column :students, :c_office_address, :string
    add_column :students, :c_city, :string
    add_column :students, :c_state, :string
    add_column :students, :c_office_phone, :string
    add_column :students, :c_mobile_phone, :string

    add_column :students, :f_office_address, :string
    add_column :students, :f_city, :string
    add_column :students, :f_state, :string

    add_column :students, :m_office_address, :string
    add_column :students, :m_city, :string
    add_column :students, :m_state, :string

    add_column :students, :phone, :string
    add_column :students, :mobile, :string
  end
end