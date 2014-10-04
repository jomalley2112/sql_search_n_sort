class CreateUnsearchables < ActiveRecord::Migration
  def change
    create_table :unsearchables do |t|
      t.integer :int
      t.date :dt
      t.time :tm
      t.datetime :dtm
      t.boolean :bool
      t.float :flt
      t.decimal :dec
      t.binary :bn
      t.timestamp :ts

      t.timestamps
    end
  end
end
