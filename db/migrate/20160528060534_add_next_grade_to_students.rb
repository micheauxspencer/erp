class AddNextGradeToStudents < ActiveRecord::Migration
  def change
    add_column :students, :next_grade, :integer
  end
end
