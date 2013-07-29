class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birthdate, :datetime
    add_column :users, :gender, :string
  end
end
