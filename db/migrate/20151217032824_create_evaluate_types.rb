class CreateEvaluateTypes < ActiveRecord::Migration
  def change
    create_table :evaluate_types do |t|
      t.string :name
      t.references :report_template, index: true

      t.timestamps
    end
  end
end
