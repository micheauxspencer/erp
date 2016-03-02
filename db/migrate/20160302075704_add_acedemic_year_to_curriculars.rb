class AddAcedemicYearToCurriculars < ActiveRecord::Migration
  def change
    add_column :curriculars, :acedemic_year_id, :integer
  end
end
