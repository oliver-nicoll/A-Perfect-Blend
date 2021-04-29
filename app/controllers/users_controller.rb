class UsersController < ApplicationController
  
      def profile
        redirect_if_not_logged_in_as_vendor_or_admin
        @user = User.find_by(id: params[:id])
      end

      def new
        @user = User.new
      end
    
      def create
        @user = User.new(user_params)
        if @user.save
          flash[:message] = "Successfully signed up."
          session[:user_id] = @user.id
          redirect_to products_path
        else
          render :new
        end
      end
      
      def edit
        redirect_if_not_logged_in_as_vendor_or_admin
        @user = User.find_by(id: params[:id])
      end

      def update
        redirect_if_not_logged_in_as_vendor_or_admin

        @user = User.find_by(id: params[:id])
        @user.update(user_params)
        
        if @user.valid?
            redirect_to profile_path(@user)
        else 
            flash[:message] = "User not valid"
            render :edit
        end
      end
    
      def destroy
        session.delete("user_id")
        redirect_to root_path
      end
  
      private
  
      def user_params
        params.require(:user).permit(:role, :vendor, :name, :username, :password, :email, :business_name)
      end
end
