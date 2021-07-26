class ToppagesController < ApplicationController
  def index
    @recent_photos = Photo.order("id DESC").first(7)
    liked_photo_ids = UserPhotoLike.order("id DESC").first(7).pluck("photo_id")
    @liked_photos = Photo.find(liked_photo_ids)
  end
end
