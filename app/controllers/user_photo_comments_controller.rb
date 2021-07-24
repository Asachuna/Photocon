class UserPhotoCommentsController < ApplicationController
    before_action :require_user_logged_in
    
    def create
        @comment = UserPhotoComment.new(comment_params)
        
        if correct_user?(@comment)
    
          if @comment.save
            flash[:main] = 'コメントを送信しました。'
            redirect_to @comment.photo
          else
            flash.now[:accent] = 'コメントの送信に失敗しました。'
            @photo = @comment.photo
            render "photos/show", id: @comment.photo_id
          end
        else
          flash[:main] = 'コメントの送信に失敗しました。'
          redirect_back(fallback_location: photos_path)
        end
            
    end
    
    def destroy
        @comment = current_user.user_photo_comments.find_by(id: params[:id])
          
        if @comment
          @comment.destroy
          flash[:main] = "コメントを削除しました。"
          redirect_back(fallback_location: photos_path)
        else
          redirect_back(fallback_location: photos_path)
        end
    end
        
    private
    
    def comment_params
        params.require(:user_photo_comment).permit(:photo_id, :content, :user_id, :photo_id)
    end
    
end
