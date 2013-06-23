class AddRequestBasketIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :request_basket_id, :integer
  end
end
