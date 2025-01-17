class ApplicationController < ActionController::Base
  helper_method :current_user 

    def current_user 
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end 

    def require_user
        if !current_user
          flash[:error] = "You must be a registered user to access this page"
          redirect_to "/"
        end 
    end
end
