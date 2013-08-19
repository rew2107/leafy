class CreateShopperApplications < ActiveRecord::Migration
  def change
    create_table :shopper_applications do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :zipcode
      t.text :why_question
      t.text :other_accounts_question
      t.text :shipping_question
      t.integer :user_id
      t.timestamps
    end
  end
end
