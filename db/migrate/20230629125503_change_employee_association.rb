class ChangeEmployeeAssociation < ActiveRecord::Migration[7.0]
  def change
    remove_reference :employees, :departments
    add_reference :employees, :department
  end
end
