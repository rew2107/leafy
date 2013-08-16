class AddShopperToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shopper, :boolean, :default => false
  end
end
