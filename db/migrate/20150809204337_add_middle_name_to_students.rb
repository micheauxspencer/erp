class AddMiddleNameToStudents < ActiveRecord::Migration
  def change
    add_column :students, :middle_name, :string
    add_column :students, :last_shool_attended, :string
    add_column :students, :last_school_phone, :string
    add_column :students, :custody, :text
    add_column :students, :nearest_intersection, :string
    add_column :students, :health_notes, :text
  end
end
