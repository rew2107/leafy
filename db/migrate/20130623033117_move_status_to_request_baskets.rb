class MoveStatusToRequestBaskets < ActiveRecord::Migration
  def up
    add_column :request_baskets, :status, :string, :default => RequestBasket::ACTIVE
    remove_column :requests, :status
  end

  def down
    add_column :requests, :status, :string, :default => RequestBasket::ACTIVE
    remove_column :request_baskets, :status
  end
end
