class AddMarkTypeToEvaluates < ActiveRecord::Migration
  def change
    add_column :evaluates, :mark_type, :integer
  end
end
