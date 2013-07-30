class Message < ActiveRecord::Base
  include Tire::Model::Search
  attr_accessible :text, :parent_message_id, :read, :sender_id, :receiver_id, :title
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  belongs_to :parent_message, :class_name => 'Message'
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
    indexes :read_all, :as => 'read_all', type: "boolean", :include_in_all => false
    indexes :all_text, :analyzer => 'snowball'
  end

  def read_all
    return self.read if self.read == false || self.parent_message_id.present?
    return false if self.messages.exists?(:read => false)
    true
  end

  def all_text
    text = self.messages.map do |m|
      [m.text, m.title].join(' ')
    end
    text << [self.text, self.title].join(' ')
    text.join(' ')
  end

  private

  def update_tire
    tire.update_index if self.parent_message_id.blank?
  end
end
