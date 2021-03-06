class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :description,
    :photo, :country_id, :favorite_products_attributes, :local_favorites_attributes, :foreign_favorites_attributes, :gender, :birthdate, :routine, :secrets

  has_many :favorite_products, :limit => FavoriteProduct::MAX_ALLOWED_PER_TYPE * 2
  has_many :foreign_favorites, :class_name => 'FavoriteProduct', :conditions => {:foreign => true}, :limit => FavoriteProduct::MAX_ALLOWED_PER_TYPE
  has_many :local_favorites, :class_name => 'FavoriteProduct', :conditions => {:foreign => false}, :limit => FavoriteProduct::MAX_ALLOWED_PER_TYPE
  has_many :request_baskets, :foreign_key => :requester_id
  has_many :shopping_baskets, :class_name => 'RequestBasket', :foreign_key => :shopper_id
  has_many :sent_messages, :class_name => 'Message', :foreign_key => :sender_id
  has_many :received_messages, :class_name => 'Message', :foreign_key => :receiver_id
  belongs_to :country
  has_one :shopper_application
  has_many :bids

  accepts_nested_attributes_for :favorite_products, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :foreign_favorites, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :local_favorites, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true

  validates_attachment :photo,
    :content_type => { :content_type => ["image/jpg", "image/png", "image/jpeg", "image/gif"] },
    :size => { :in => 0..4.megabytes }

  has_attached_file :photo, :default_url => '/assets/missing_person.png', :styles => {
    thumb: '64x64#',
    square: '140x140#',
    larger: '200x200#'
  }

  def offers
    Bid.where(:request_basket_id => self.request_baskets.map(&:id))
  end

  def password_required?
    (!persisted? || !password.nil? || !password_confirmation.nil?) if confirmed?
  end

  def password_match?
    self.errors[:password] << "cannot be blank" if password.blank?
    self.errors[:password_confirmation] << "cannot be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  def email_required?
    true
  end

  def fullname
    "#{first_name} #{last_name}" if first_name.present? || last_name.present?
  end

  def age
    return nil unless birthdate.present?
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end
end
