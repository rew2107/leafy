class Request < ActiveRecord::Base

  attr_accessible :title, :description, :photo

  belongs_to :request_basket

  validates_presence_of :title, :description
  validates :request_basket, :associated => true


  validates_attachment :photo,
    :content_type => { :content_type => ["image/jpg", "image/png", "image/jpeg", "image/gif"] },
    :size => { :in => 0..4.megabytes }

  has_attached_file :photo, :default_url => '/assets/:style/missing_product.jpg', :styles => {
    thumb: '64x64>',
    square: '140x140#',
    big: '290x290#'
  }
end

