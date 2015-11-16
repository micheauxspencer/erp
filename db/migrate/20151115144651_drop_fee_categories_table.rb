class DropFeeCategoriesTable < ActiveRecord::Migration
  def change
    def up
      drop_table :fee_categories
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
  end
end
