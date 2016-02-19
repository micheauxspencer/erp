class AddMedicalInfoToStudents < ActiveRecord::Migration
  def change
    add_column :students, :medical_conditions, :text
    add_column :students, :medicated, :boolean
    add_column :students, :medication, :string
  end
end
