class AddReportTemplateIdToEvaluates < ActiveRecord::Migration
  def change
    add_reference :evaluates, :report_template, index: true
  end
end
