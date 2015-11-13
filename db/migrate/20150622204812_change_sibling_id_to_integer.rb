class ChangeSiblingIdToInteger < ActiveRecord::Migration
 def up
    change_column :students, :sibling_id, :integer
  end

  def down
    change_column :students, :sibling_id, :string
  end
end
