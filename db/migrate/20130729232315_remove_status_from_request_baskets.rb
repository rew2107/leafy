class RemoveStatusFromRequestBaskets < ActiveRecord::Migration
  def up
    remove_column :request_baskets, :status
    add_column :request_baskets, :completed, :boolean, :default => false
  end

  def down
    remove_column :request_baskets, :completed
    add_column :request_baskets, :status, :string
  end
end
