class CreateFavoriteProducts < ActiveRecord::Migration
  def change
    create_table :favorite_products do |t|
      t.string :title
      t.text :description
      t.attachment :photo
      t.boolean :foreign
      t.integer :user_id
      t.timestamps
    end
  end
end
