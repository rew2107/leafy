class FavoriteProduct < ActiveRecord::Base
  attr_accessible :title, :description, :photo, :foreign

  belongs_to :user
  validates_attachment :photo,
    :content_type => { :content_type => ["image/jpg", "image/png", "image/jpeg", "image/gif"] },
    :size => { :in => 0..4.megabytes }

  has_attached_file :photo, :default_url => '/assets/missing_product.jpg', :styles => {
    thumb: '64x64>',
    square: '140x140#'
  }
end

