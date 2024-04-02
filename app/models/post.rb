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

  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end

  def favorited_by?(enduser)
    favorites.exists?(enduser_id: enduser.id)
  end

  def self.rank_posts(category_id)
    self.joins(:favorites).where(category_id: category_id).group(:post_id).order('COUNT(post_id) DESC')
  end

  def self.all_rank_posts
    self.joins(:favorites).all.group(:post_id).order('COUNT(post_id) DESC')
  end

end