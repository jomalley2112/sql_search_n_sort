class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :descr
      t.integer :price
      t.datetime :date_produced
      t.string :manufacturer

      t.timestamps
    end
  end
end
