class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :email
      t.text :bio
      t.string :nickname

      t.timestamps
    end
  end
end
