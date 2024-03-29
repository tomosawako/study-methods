class PostComment < ApplicationRecord
  belongs_to :enduser
  belongs_to :post
  belongs_to :parent, class_name: "PostComment", optional: true
  has_many :replies, class_name: "PostComment", foreign_key: :parent_id, dependent: :destroy

  validates :comment, presence: true, length: {maximum: 200}

end