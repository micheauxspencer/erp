class AddStatusToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :status, :boolean
  end
end
