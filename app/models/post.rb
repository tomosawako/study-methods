class Post < ApplicationRecord
  belongs_to :enduser
  has_one_attached :image
end
