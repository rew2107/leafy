class MoveStatusToRequestBaskets < ActiveRecord::Migration
  def up
    add_column :request_baskets, :status, :string, :default => 'active'
    remove_column :requests, :status
  end

  def down
    add_column :requests, :status, :string, :default => 'active'
    remove_column :request_baskets, :status
  end
end
