class AddColumnAvailbleHoursToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :available_hours, :float, default: 0
  end
end
