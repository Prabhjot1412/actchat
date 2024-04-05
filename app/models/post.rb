class Post < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  has_one_attached :post_image
end
