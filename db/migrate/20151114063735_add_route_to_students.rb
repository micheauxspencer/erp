class AddRouteToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :route, index: true
  end
end
