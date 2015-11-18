class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name
      t.integer :academic_year_id

      t.timestamps
    end
  end
end
