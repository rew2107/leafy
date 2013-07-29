class Bid < ActiveRecord::Base
  attr_accessible :amount, :request_basket_id
  belongs_to :request_basket

  belongs_to :user
end
