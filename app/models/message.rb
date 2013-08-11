class Message < ActiveRecord::Base
  include Tire::Model::Search
  attr_accessible :text, :parent_message_id, :read, :sender_id, :receiver_id, :title
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  belongs_to :parent_message, :class_name => 'Message', :touch => true
  has_many :messages, :foreign_key => :parent_message_id, :dependent => :destroy

  validates_presence_of :receiver_id, :sender_id, :text

  after_save :update_tire
  after_destroy :update_tire

  if self.respond_to?(:before_destroy) && !self.instance_methods.map(&:to_sym).include?(:destroyed?)
    self.class_eval do
      before_destroy  { @destroyed = true }
      def destroyed?; !!@destroyed; end
    end
  end

   mapping do
    indexes :id, :include_in_all => false, :index => :no
    indexes :sender_id, :include_in_all => false, :type => :integer
    indexes :receiver_id, :include_in_all => false, :type => :integer
    indexes :receiver_name, :as => 'receiver.fullname'
    indexes :sender_name, :as => 'receiver.fullname'
    indexes :created_at, :type => :date, :include_in_all => false, :index => :not_analyzed
    indexes :unread_id, :as => 'unread_id', type: "integer", :include_in_all => false
    indexes :all_text, :as => 'all_text', :analyzer => 'snowball'
    indexes :text, :analyzer => 'snowball'
    indexes :title, :analyzer => 'snowball'
  end

  def unread_id
    return self.receiver_id if self.read == false
    unread_message = self.messages.where(:read => false).first
    return nil unless unread_message.present?
    unread_message.receiver_id
  end

  def all_text
    self.messages.map do |m|
      [m.text, m.title].join(' ')
    end.join(' ')
  end

  private

  def update_tire
    if self.parent_message_id.blank?
      tire.update_index
    else
      self.parent_message.update_index
    end
  end
end
