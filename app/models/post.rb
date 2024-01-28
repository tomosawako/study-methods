class Post < ApplicationRecord
  belongs_to :enduser
  belongs_to :category
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image

  validates :category_id, presence: true
  validates :field, presence: true
  validates :reference_book, presence: true
  validates :study_method, presence: true
  validates :total_study_time, presence: true
  validates :achievement, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end




