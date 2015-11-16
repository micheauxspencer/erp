class DropTeachersTable < ActiveRecord::Migration
  def change
    def up
      drop_table :teachers
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
  end
end
