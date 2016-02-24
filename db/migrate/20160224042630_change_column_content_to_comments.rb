class ChangeColumnContentToComments < ActiveRecord::Migration
  def change
    change_column :comments, :content, :string, :limit => 2000
  end
end
