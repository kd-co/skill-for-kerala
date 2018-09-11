class AddRolesAndAvailablityToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :available, :boolean, default: false
    add_column :users, :role, :integer, default: 0
  end
end
