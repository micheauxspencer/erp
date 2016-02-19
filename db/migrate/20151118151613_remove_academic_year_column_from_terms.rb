class RemoveAcademicYearColumnFromTerms < ActiveRecord::Migration
  def change
    remove_column :terms, :academic_year_id
  end
end
