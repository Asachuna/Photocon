class UserPhotoLikesController < ApplicationController
    
    include ContestsHelper
    
    before_action :require_user_logged_in
    
    def create
        photo = Photo.find(params[:photo_id])
        redirect_back(fallback_location: photo) unless contest_in_progress?(photo.contest)        
        
        current_user.like(photo)
        redirect_back(fallback_location: photo)
    end
    
    def destroy
        photo = Photo.find(params[:photo_id])
        redirect_back(fallback_location: photo) unless contest_in_progress?(photo.contest)
        
        current_user.unlike(photo)
        redirect_back(fallback_location: photo)
    end
end
