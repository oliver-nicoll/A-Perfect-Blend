class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include ApplicationHelper
    
    before_action :current_cart
    add_flash_types :danger, :info, :warning, :sucess
    
      private
          
      def redirect_if_not_logged_in  
        redirect_to login_path if !logged_in?
      end

      def redirect_if_not_logged_in_as_customer
        redirect_to root_path if !logged_in_as_customer?
      end

  
      def redirect_if_not_logged_in_as_vendor_or_admin
          redirect_to root_path if !vendor_user_or_admin?
      end

      

  private
  
    def current_cart
      if session[:cart_id]
        cart = Cart.find_by(:id => session[:cart_id])
        if cart.present?
          @current_cart = cart
        else
          session[:cart_id] = nil
        end
      end

      if session[:cart_id] == nil
        @current_cart = Cart.create
        session[:cart_id] = @current_cart.id
      end
    end
end
