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

      def set_vendor_id_to_new_product
        if current_user.vendor? 
          @user_id = current_user.id
          @vendor_id =  @product.vendor_id.to_i
          binding.pry
          @vendor_id = @user_id
        end

      end
end
