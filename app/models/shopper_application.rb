class ShopperApplication < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :zipcode, :why_question, :other_accounts_question, :shipping_question
  belongs_to :user
end
