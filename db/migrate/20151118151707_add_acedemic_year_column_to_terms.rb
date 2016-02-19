class AddAcedemicYearColumnToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :acedemic_year_id, :integer, index: true
  end

end
