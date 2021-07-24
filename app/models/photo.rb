class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :contest
  
  has_many :user_photo_likes, dependent: :destroy
  has_many :liked_users, through: :user_photo_likes, source: :user
  
  has_many :user_photo_comments, dependent: :destroy
  has_many :commented_users, through: :user_photo_comments, source: :user
 
  mount_uploader :image, ImageUploader
  
  validates :title, presence: false, length: { maximum: 25 }
  validates :description, presence: false, length: { maximum: 255 }
  validates :image, presence: true
  
  def count_likes
    self.liked_users.count
  end
  
end
