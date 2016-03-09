class AddStatusToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :status, :string, :default => "Inactive"
  end
end
