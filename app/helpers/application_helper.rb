module ApplicationHelper
    def current_user
        @user ||= User.find_by_id(session[:user_id])
    end

    def logged_in?
        !!current_user
    end

    def vendor_user?
        
        user = User.find_by()
        if user.vendor?
            #able to edit and add new products
        else
            redirect_if_not_logged_in_as_vendor
        end
    end

    def customer_user?

        user = User.find_by()
        if user.customer?
            #able to just see the market products and shop
        else
            redirect_to root_path
        end
    end
end
