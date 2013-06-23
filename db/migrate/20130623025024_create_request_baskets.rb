class CreateRequestBaskets < ActiveRecord::Migration
  def change
    create_table :request_baskets do |t|
      t.integer :country_id
      t.integer :requester_id
      t.integer :shopper_id
      t.timestamps
    end
  end
end
