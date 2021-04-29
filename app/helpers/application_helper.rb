module ApplicationHelper
    def current_user
        @user ||= User.find_by_id(session[:user_id])
    end

    def logged_in?
        !!current_user
    end

    def vendor_user_or_admin?
        if current_user && current_user.vendor
            true
            
        elsif current_user && current_user.admin
            true
        else
            flash[:notice] = "Sorry you are not authorized to do that action - rerouting to home page"
            redirect_if_not_logged_in_as_vendor_or_admin
        end
    end

    # def customer_user?

    #     user = User.find_by()
    #     if user.customer?
    #         #able to just see the market products and shop
    #     else
    #         #fla
    #         redirect_to root_path
    #     end
    # end
end
