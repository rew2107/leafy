class AddDescriptionColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :routine, :text
    add_column :users, :secrets, :text
  end
end
