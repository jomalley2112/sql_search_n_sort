class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :headline
      t.string :by_line
      t.datetime :date_pub
      t.text :body

      t.timestamps
    end
  end
end
