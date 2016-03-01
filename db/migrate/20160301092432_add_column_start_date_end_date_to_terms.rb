class AddColumnStartDateEndDateToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :start_date, :date
    add_column :terms, :end_date, :date
  end
end
