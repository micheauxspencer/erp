class RemoveNextGradeInStudnets < ActiveRecord::Migration
  def change
    remove_column :students, :next_grade
  end
end