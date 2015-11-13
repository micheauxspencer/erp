class RemoveSatusFromRoutes < ActiveRecord::Migration
  def change
    remove_column :routes, :status, :boolean
  end
end
