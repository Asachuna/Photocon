class ApplicationController < ActionController::Base
    
    SIDEBAR_CONTESTS_SHOW_AMOUNT = 5
    
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
        @sidebar_contests = Contest.first(SIDEBAR_CONTESTS_SHOW_AMOUNT)
    end
    
end
