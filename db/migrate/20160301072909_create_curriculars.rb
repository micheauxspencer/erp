class CreateCurriculars < ActiveRecord::Migration
  def change
    create_table :curriculars do |t|
      t.references :student, index: true
      t.string :content, limit: 2000

      t.timestamps
    end
  end
end
