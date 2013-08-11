class RequestBasket < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :country_id, :requests_attributes, :completed

  belongs_to :country
  belongs_to :requester, :class_name => 'User'
  belongs_to :shopper, :class_name => 'User'
  has_many :requests
  has_many :bids

  validates_presence_of :requester_id, :country_id
  validates :requester, :associated => true

  accepts_nested_attributes_for :requests, :reject_if => lambda { |a| a[:title].blank? || a[:description].blank? }

  def title
    requests.map(&:title).join(", ")
  end

  def price
    requests.map(&:price).compact.sum
  end

  def description
    requests.map(&:description).join(" ")
  end

  def self_photo
    shopper.photo.url(:thumb) if shopper
    '/assets/missing_person.png'
  end

  def requester_name
    requester.fullname
  end

  mapping do
    indexes :id, :include_in_all => false, :index => :no
    indexes :requester_id, :as => 'requester.id', :include_in_all => false, :type => :integer
    indexes :requester_name, :as => 'requester_name'
    indexes :photo, :as => 'requester.photo.url(:thumb)', :include_in_all => false, :index => :no
    indexes :created_at, :type => :date, :include_in_all => false, :index => :not_analyzed
    indexes :country_id, :include_in_all => false, :index => :not_analyzed, :analyzer => 'keyword'
    indexes :completed, type: "boolean", :include_in_all => false, :index => :not_analyzed
    indexes :title, :as => 'title', :analyzer => 'snowball', :boost => 10
    indexes :description, :as => 'description', :analyzer => 'snowball', :store => false
    indexes :price, :as => 'price', :include_in_all => false, :type => :integer
  end
end
