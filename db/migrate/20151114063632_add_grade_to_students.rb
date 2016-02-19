class AddGradeToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :grade, index: true
  end
end
