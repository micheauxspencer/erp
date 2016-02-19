class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.integer :sin
      t.date :birthdate
      t.boolean :trans_req
      t.boolean :tax_rec_req
      t.string :route_fee
      t.boolean :pick_up
      t.boolean :drop_off
      t.integer :sibling_id
      t.string :f_first_name
      t.string :f_last_name
      t.string :f_street
      t.string :f_city
      t.string :f_province
      t.string :f_postal
      t.string :f_phone
      t.string :m_first_name
      t.string :m_last_name
      t.string :m_street
      t.string :m_city
      t.string :m_province
      t.string :m_postal
      t.string :m_phone
      t.string :email
      t.string :emerg_1_name
      t.string :emerg_1_phone
      t.string :emerg_1_relation
      t.string :emerg_2_name
      t.string :emerg_2_phone
      t.string :emerg_2_relation
      t.string :healthcard
      t.string :doctor_name
      t.string :doctor_phone
      t.boolean :enrolled
      t.timestamps
    end
  end
end
