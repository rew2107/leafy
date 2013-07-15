class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :request_basket_id
      t.integer :parent_message_id
      t.boolean :read, :default => false
      t.text :text
      t.timestamps
    end
  end
end
