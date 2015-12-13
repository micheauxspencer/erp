class DropGradesTermsTable < ActiveRecord::Migration
  def change
    def up
      drop_table :term_grades
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
  end
end
