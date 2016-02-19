class DropTableClassName < ActiveRecord::Migration
  def change
    drop_table :class_names
    drop_table :term_classes
  end
end
