class RemoveFieldsFromRequests < ActiveRecord::Migration
  def up
    remove_column :requests, :country_id
    remove_column :requests, :requester_id
    remove_column :requests, :shopper_id
  end

  def down
    add_column :requests, :country_id, :interger
    add_column :requests, :requester_id, :integer
    add_column :requests, :shopper_id, :integer
  end
end
