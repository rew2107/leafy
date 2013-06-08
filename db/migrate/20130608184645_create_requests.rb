class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :country_id
      t.integer :requester_id
      t.integer :shopper_id
      t.string :title
      t.text :description
      t.attachment :photo
      t.timestamps
    end
  end
end
