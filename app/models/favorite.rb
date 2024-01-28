class Favorite < ApplicationRecord
  belongs_to :post
  belongs_to :enduser
end
