class AddPriceToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :price, :integer
  end
end
