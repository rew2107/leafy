class Message < ActiveRecord::Base
  attr_accessible :text, :parent_message_id, :read
  belongs_to :request_basket
  belongs_to :sender, :class_name => 'User'
  belongs_to :parent_message, :class_name => 'Message'

  has_one :requester, :through => :request_basket
end
