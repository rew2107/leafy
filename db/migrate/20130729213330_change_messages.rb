class ChangeMessages < ActiveRecord::Migration
  def up
    add_column :messages, :title, :string
    remove_column :messages, :request_basket_id
  end

  def down
    add_column :messages, :request_basket_id, :integer
    remove_column :messages, :title
  end
end
