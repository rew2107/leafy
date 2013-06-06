class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :description, :photo, :country_id

  has_many :favorite_products
  belongs_to :country

  validates_attachment :photo,
    :content_type => { :content_type => ["image/jpg", "image/png", "image/jpeg", "image/gif"] },
    :size => { :in => 0..4.megabytes }

  has_attached_file :photo, :default_url => '/assets/missing_person.png', :styles => {
    thumb: '64x64>',
    square: '140x140#'
  }

  def fullname
    "#{first_name} #{last_name}" if first_name.present? || last_name.present?
  end
end
