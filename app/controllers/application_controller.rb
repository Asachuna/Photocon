class ApplicationController < ActionController::Base
    
    SIDEBAR_CONTESTS_SHOW_AMOUNT = 5
    SIDEBAR_COMMENTS_SHOW_AMOUNT = 10
    
    before_action :get_sidebar_contents
    
    
    include Pagy::Backend
    include SessionsHelper
    
    private

    def require_user_logged_in
        unless logged_in?
            redirect_to login_url
        end
    end
    
    def get_sidebar_contents
        @sidebar_contests = Contest.order("id DESC").first(SIDEBAR_CONTESTS_SHOW_AMOUNT)
        @sidebar_comments = UserPhotoComment.order("id DESC").first(SIDEBAR_COMMENTS_SHOW_AMOUNT)
    end
    
    def correct_user?(model)
        current_user == model.user
    end
    
end
