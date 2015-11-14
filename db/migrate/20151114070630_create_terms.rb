class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name
      t.references :academic_year, index: true

      t.timestamps
    end
  end
end
