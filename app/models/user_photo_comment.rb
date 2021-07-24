class UserPhotoComment < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  
  validates :content, presence: true, length: { maximum: 255 }
  
end
