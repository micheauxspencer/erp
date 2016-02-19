class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :term_student, index: true
      t.string :content

      t.timestamps
    end
  end
end
