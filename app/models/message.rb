class Message < ActiveRecord::Base
  attr_accessible :text, :parent_message_id, :read, :sender_id, :request_basket_id, :receiver_id
  belongs_to :request_basket
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  belongs_to :parent_message, :class_name => 'Message'
  has_many :messages, :foreign_key => :parent_message_id

  has_one :requester, :through => :request_basket

  validates_presence_of :receiver_id, :sender_id, :text
end
