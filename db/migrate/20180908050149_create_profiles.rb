class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user
      t.text :bio
      t.float :total_hours
      t.string :location

      t.timestamps
    end
  end
end
