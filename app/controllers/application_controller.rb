class ApplicationController < ActionController::Base
    include Pagy::Backend

    helper_method :current_user

    private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
end
