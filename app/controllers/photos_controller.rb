class PhotosController < ApplicationController
  
  include ContestsHelper
  
  before_action :require_user_logged_in, only: [:new, :create, :destroy]
  
  def index
    @pagy, @photos = pagy(Photo.all.order(id: :desc), items: 20)
  end

  def show
    @photo = Photo.find((params[:id]))
    @pagy, @comments = pagy(@photo.user_photo_comments.order(id: :desc), items: 25)
    if logged_in?
      @comment = UserPhotoComment.new(user_id: current_user.id, photo_id: params[:id])
    end
    
    unless contest_in_progress?(@photo.contest)
      @rank = get_rank(@photo)
    end
  end

  def new
    @photo = Photo.new(user_id: current_user.id, contest_id: params[:id])
  end

  def create
    @photo = Photo.new(photo_params)

    if contest_in_progress?(@photo.contest) && correct_user?(@photo)
      
      if @photo.save
        flash[:main] = '写真を投稿しました。'
        redirect_to @photo.contest
      else
        flash.now[:accent] = '写真の投稿に失敗しました。'
        render :new
      end
      
    else
      flash[:accent] = '写真の投稿に失敗しました。'
      redirect_to @photo.contest
    end
    
  end

  def destroy
    @photo = current_user.photos.find_by(id: params[:id])
      
    if @photo
      @photo.destroy
      flash[:main] = "写真を削除しました。"
      redirect_to photos_url
    else
      redirect_to photo_path(params[:id])
    end
      
  end
  
  private

  def photo_params
    params.require(:photo).permit(:title, :description, :image, :contest_id, :user_id)
  end
  
  def get_rank(photo)
    photos_order =  photo.contest.photos.sort { |a, b| b.count_likes <=> a.count_likes }
    return photos_order.index(photo) + 1
  end
  
end
