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
          session[:user_id] = @user.id
          redirect_to root_path, info: "Successfully signed up!"
        else
          redirect_to signup_path, danger: "Try Again - Error"
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

            redirect_to profile_edit_path, danger: "User not Valid - Try Again"
        end
      end
    
      def destroy
        session.delete("user_id")
        redirect_to root_path,info: "Sad to see you go!!"
      end
  
      private
  
      def user_params
        params.require(:user).permit(:name, :username, :password, :password_confirmation, :email, :business_name)
      end
end
