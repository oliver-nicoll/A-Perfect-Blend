module ApplicationHelper
    def current_user
        @user ||= User.find_by_id(session[:user_id])
    end

    def logged_in?
        !!current_user
    end

    def vendor_user_or_admin?
        current_user && current_user.vendor? || current_user.admin?
    end
end
