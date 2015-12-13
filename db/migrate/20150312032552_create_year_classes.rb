class CreateYearClasses < ActiveRecord::Migration
  def change
    create_table :year_classes do |t|

      t.timestamps
    end
  end
end
