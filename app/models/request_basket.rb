class RequestBasket < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  ACTIVE = 'active'
  IN_PROGRESS = 'progress'
  COMPLETED = 'complete'

  attr_accessible :country_id

  belongs_to :country
  belongs_to :requester, :class_name => 'User'
  belongs_to :shopper, :class_name => 'User'
  has_many :requests

  validates_presence_of :requester_id, :country_id
  validates :requester, :associated => true

  accepts_nested_attributes_for :requests, :reject_if => lambda { |a| a[:title].blank? || a[:description].blank? }

  def title
    requests.all.map(&:title).join(", ")
  end

  def description
    requests.all.map(&:description).join(" ")
  end

  mapping do
    indexes :id, :include_in_all => false, :index => :no
    indexes :photo, :as => 'requester.photo.url(:thumb)', :include_in_all => false, :index => :no
    indexes :created_at, :type => :date, :include_in_all => false, :index => :not_analyzed
    indexes :country_id, :include_in_all => false, :index => :not_analyzed, :analyzer => 'keyword'
    indexes :status, :include_in_all => false, :index => :not_analyzed, :analyzer => 'keyword'
    indexes :title, :analyzer => 'snowball', :boost => 10
    indexes :description, :analyzer => 'snowball', :store => false
  end
end
