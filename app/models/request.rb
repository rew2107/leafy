class Request < ActiveRecord::Base
  attr_accessible :title, :country_id, :description, :photo

  belongs_to :country
  belongs_to :requester, :class_name => 'User'
  belongs_to :shopper, :class_name => 'User'

  validates_attachment :photo,
    :content_type => { :content_type => ["image/jpg", "image/png", "image/jpeg", "image/gif"] },
    :size => { :in => 0..4.megabytes }

  has_attached_file :photo, :default_url => '/assets/:style/missing_product.jpg', :styles => {
    thumb: '64x64>',
    square: '140x140#',
    big: '290x290#'
  }

end

