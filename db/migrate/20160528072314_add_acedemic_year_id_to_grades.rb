class AddAcedemicYearIdToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :acedemic_year_id, :integer
  end
end
