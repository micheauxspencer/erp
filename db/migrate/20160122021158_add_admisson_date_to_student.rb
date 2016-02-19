class AddAdmissonDateToStudent < ActiveRecord::Migration
  def change
    add_column :students, :admission_date, :datetime
  end
end
