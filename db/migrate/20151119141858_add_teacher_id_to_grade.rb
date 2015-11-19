class AddTeacherIdToGrade < ActiveRecord::Migration
  def change
    add_column :grades, :teacher_id, :integer, index: true
  end
end
