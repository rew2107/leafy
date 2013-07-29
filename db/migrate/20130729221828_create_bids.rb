class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :amount
      t.integer :request_basket_id
      t.integer :user_id
      t.timestamps
    end
  end
end
