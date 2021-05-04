module ApplicationHelper
    def current_user
        @current_user ||= User.find_by_id(session[:user_id])
    end

    def logged_in?
        !!current_user
    end

    def logged_in_as_customer?
        !!current_user && !!current_user.customer?
    end

    def logged_in_as_vendor?
        !!current_user && !!current_user.vendor?
    end

    def logged_in_as_admin?
        !!current_user && !!current_user.admin?
    end

    def customer_or_vendor?
        !!current_user && !!current_user.customer? || !!current_user.vendor?
    end

    def vendor_user_or_admin?
        !!current_user && !!current_user.vendor? || !!current_user.admin?
    end



    def subtotal_cart
        sum = 0

        self.cart_products.each { |p| sum+= p.total_price }

        return sum 
        
    end
end
