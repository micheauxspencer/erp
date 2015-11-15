class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :type
      t.string :category
      t.integer :indicator
      t.integer :teacher_id, index: true
      t.references :class_name, index: true

      t.timestamps
    end
  end
end
