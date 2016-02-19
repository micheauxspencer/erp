class CreateTermClasses < ActiveRecord::Migration
  def change
    create_table :term_classes do |t|
      t.references :class_name, index: true
      t.references :term, index: true

      t.timestamps
    end
  end
end
