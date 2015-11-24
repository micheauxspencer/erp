class ChangeSiblingIdToInteger < ActiveRecord::Migration
 def up
    change_column :students, :sibling_id, :integer #, 'integer USING CAST(column_name AS integer)'
  end

  def down
    change_column :students, :sibling_id, :string
  end
end
