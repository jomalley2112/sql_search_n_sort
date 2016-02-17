class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :ctext
      t.string :commentator
    end
  end
end
