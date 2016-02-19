class DropSubjectsTable < ActiveRecord::Migration
  def change
    def up
      drop_table :subjects
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
  end
end
