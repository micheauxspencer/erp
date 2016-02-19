class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :name
      t.string :details
      t.boolean :status

      t.timestamps
    end
  end
end
