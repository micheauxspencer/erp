class AddGradeToReportTemplate < ActiveRecord::Migration
  def up
    add_column :grades, :report_template_id, :integer
    Grade.where(report_template_id: nil).update_all(report_template_id: ReportTemplate.all.first.id)
  end

  def down
    remove_columns :grades, :report_template_id
  end
end
