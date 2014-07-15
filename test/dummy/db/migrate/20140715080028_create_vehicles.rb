class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.integer :year
      t.string :manufacturer
      t.string :model
      t.string :color
      t.string :engine
      t.integer :doorrs
      t.integer :cylinders

      t.timestamps
    end
  end
end
