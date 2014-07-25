class AddDobAndGradeToPeople < ActiveRecord::Migration
  def change
    add_column :people, :dob, :datetime
    add_column :people, :grade, :integer
  end
end
