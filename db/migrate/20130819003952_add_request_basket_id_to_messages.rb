class AddRequestBasketIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :request_basket_id, :integer
  end
end
