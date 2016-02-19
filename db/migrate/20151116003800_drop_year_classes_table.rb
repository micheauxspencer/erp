class DropYearClassesTable < ActiveRecord::Migration
  def change
    def up
      drop_table :year_classes
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
  end
end
