class UsersController < ApplicationController
  
      def profile
        @user = User.find_by(id: params[:id])
      end

      def new
        @user = User.new
      end
    
      def create
        
        @user = User.new(user_params)
      
        @user.role = params[:user][:role].to_i
        
        if @user.save
          flash[:message] = "Successfully signed up."
          session[:user_id] = @user.id
          redirect_to root_path
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
        params.require(:user).permit(:name, :username, :password, :password_confirmation, :email, :business_name)
      end
end
