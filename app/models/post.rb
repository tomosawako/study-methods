class Post < ApplicationRecord
  belongs_to :enduser
  belongs_to :category
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :image

  validates :category_id, presence: true
  validates :field, presence: true
  validates :reference_book, presence: true
  validates :study_method, presence: true, length: {maximum: 200}
  validates :total_study_time, presence: true
  validates :achievement, presence: true, length: {maximum: 200}

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(enduser)
    favorites.exists?(enduser_id: enduser.id)
  end

  def self.rank_posts(category_id)
    self.joins(:favorites).where(category_id: category_id).group(:post_id).order('COUNT(post_id) DESC')
  end

end




