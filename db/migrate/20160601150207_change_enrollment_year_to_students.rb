class ChangeEnrollmentYearToStudents < ActiveRecord::Migration
  def change
    remove_column :students, :enrollment_year
    add_column :students, :enrollment_year, :integer
  end
end
