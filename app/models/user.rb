class User < ApplicationRecord
    has_many :contests, dependent: :destroy
    has_many :photos, dependent: :destroy
    
    has_many :user_photo_likes, dependent: :destroy
    has_many :liked_photos, through: :user_photo_likes, source: :photo
    
    has_many :user_photo_comments, dependent: :destroy
    has_many :commented_photos, through: :user_photo_comments, source: :photo


    has_secure_password
    validates :name, presence: true, length: { maximum: 15 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    
  def like(photo)
    self.user_photo_likes.find_or_create_by(photo_id: photo.id)
  end
  
  def unlike(photo)
    user_photo_like = self.user_photo_likes.find_by(photo_id: photo.id)
    user_photo_like.destroy if user_photo_like
  end
  
  def liked?(photo)
    self.liked_photos.include?(photo)
  end

end
