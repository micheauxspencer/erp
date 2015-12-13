class AddTermIdToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :term, index: true
  end
end
