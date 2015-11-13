class RemoveSatusFromRoutes < ActiveRecord::Migration
  def change
    remove_column :routes, :satus, :boolean
  end
end
