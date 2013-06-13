class AddStatusToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :status, :string, :default => Request::ACTIVE
  end
end
