class Favorite < ApplicationRecord
  belongs_to :post
  belongs_to :enduser

  validates :enduser_id, uniqueness: {scope: :post_id}

end
