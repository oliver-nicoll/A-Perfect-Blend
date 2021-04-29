class UsersController < ApplicationController
      def profile
        render :edit
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
    
      def destroy
        session.delete("user_id")
        redirect_to root_path
      end
  
      private
  
      def user_params
        params.require(:user).permit(:role, :vendor, :name, :username, :password, :email)
      end
end
