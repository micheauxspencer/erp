class AddTransferredToStudent < ActiveRecord::Migration
  def change
    add_column :students, :transferred, :boolean, default: false
  end
end
