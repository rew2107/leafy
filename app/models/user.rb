class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :description,
    :photo, :country_id, :favorite_products_attributes, :local_favorites_attributes, :foreign_favorites_attributes

  has_many :favorite_products, :limit => FavoriteProduct::MAX_ALLOWED_PER_TYPE * 2
  has_many :foreign_favorites, :class_name => 'FavoriteProduct', :conditions => {:foreign => true}, :limit => FavoriteProduct::MAX_ALLOWED_PER_TYPE
  has_many :local_favorites, :class_name => 'FavoriteProduct', :conditions => {:foreign => false}, :limit => FavoriteProduct::MAX_ALLOWED_PER_TYPE
  has_many :request_baskets, :foreign_key => :requester_id
  has_many :shopping_baskets, :class_name => 'RequestBasket', :foreign_key => :shopper_id
  has_many :sent_messages, :class_name => 'Message', :foreign_key => :sender_id
  has_many :received_messages, :class_name => 'Message', :foreign_key => :receiver_id
  belongs_to :country

  accepts_nested_attributes_for :favorite_products, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :foreign_favorites, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :local_favorites, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true

  validates_attachment :photo,
    :content_type => { :content_type => ["image/jpg", "image/png", "image/jpeg", "image/gif"] },
    :size => { :in => 0..4.megabytes }

  has_attached_file :photo, :default_url => '/assets/missing_person.png', :styles => {
    thumb: '64x64#',
    square: '140x140#'
  }

  def active_request_baskets
    request_baskets.where('status = ?', RequestBasket::ACTIVE)
  end

  def in_progress_request_baskets
    request_baskets.where('status = ?', RequestBasket::IN_PROGRESS)
  end

  def completed_request_baskets
    request_baskets.where('status = ?', RequestBasket::COMPLETED)
  end

  def completed_shopping_baskets
    shopping_baskets.where('status = ?', RequestBasket::COMPLETED)
  end

  def in_progress_shopping_baskets
    shopping_baskets.where('status = ?', RequestBasket::IN_PROGRESS)
  end

  def fullname
    "#{first_name} #{last_name}" if first_name.present? || last_name.present?
  end
end
