class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.references :user
      t.string :owner_email
      t.string :owner_name
      t.float :amount
      t.text :description

      t.timestamps
    end
  end
end
