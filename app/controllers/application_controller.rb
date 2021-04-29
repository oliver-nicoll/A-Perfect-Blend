class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include CurrentCart
    include ApplicationHelper
    before_action :set_cart
      
      private
          
      def redirect_if_not_logged_in  
        redirect_to login_path if !logged_in?
      end
  
      def redirect_if_not_logged_in_as_vendor_or_admin
          redirect_to root_path if !vendor_user_or_admin?
      end
end
