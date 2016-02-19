class CreateClassNames < ActiveRecord::Migration
  def change
    create_table :class_names do |t|
      t.references :grade, index: true
      t.string :name

      t.timestamps
    end
  end
end
