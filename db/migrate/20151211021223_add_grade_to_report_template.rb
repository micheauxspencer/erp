class AddGradeToReportTemplate < ActiveRecord::Migration
  def up
    add_column :grades, :report_template_id, :integer
  end

  def down
    remove_columns :grades, :report_template_id
  end
end
