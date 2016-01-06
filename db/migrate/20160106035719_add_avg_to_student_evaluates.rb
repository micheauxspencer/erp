class AddAvgToStudentEvaluates < ActiveRecord::Migration
  def change
    add_column :student_evaluates, :avg, :integer
  end
end
