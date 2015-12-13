class CreateYearRoutes < ActiveRecord::Migration
  def change
    create_table :year_routes do |t|
      t.integer :acedemic_year_id
      t.integer :route_id

      t.timestamps
    end
  end
end
