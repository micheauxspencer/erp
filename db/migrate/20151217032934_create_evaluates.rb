class CreateEvaluates < ActiveRecord::Migration
  def change
    create_table :evaluates do |t|
      t.string :name
      t.references :evaluate_type, index: true

      t.timestamps
    end
  end
end
