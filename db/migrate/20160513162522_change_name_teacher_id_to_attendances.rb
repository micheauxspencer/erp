class ChangeNameTeacherIdToAttendances < ActiveRecord::Migration
  def change
    rename_column :attendances, :teacher_id, :user_id
  end
end
