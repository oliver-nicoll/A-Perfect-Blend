class SessionsController < ApplicationController
    def new

    end
  
    def create
        @user = User.find_by_username(params[:user][:username])
  
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            redirect_to root_path, info: "Signed in with Google"
        else
    
            redirect_to login_path, danger: "Try Again - Not Valid"
            
        end
    end
  
    def logout
      session.clear
      redirect_to login_path, info: "See you next time!"
    end
  
      def omniauth
              
          @user = User.find_or_create_by(username: auth[:info][:email]) do |u|
              u.email = auth[:info][:email]
              u.username = auth[:info][:email]
              u.name = auth[:info][:name]
              u.uid = auth[:uid]
              u.provider = auth[:provider]
              u.password = SecureRandom.hex(10)
              u.role
          end
          
          if @user.valid?
              session[:user_id] = @user.id
              redirect_to root_path, info: "Signed in with Google"
          else
              redirect_to login_path, danger: "Try Again - Not Valid"
          end
      end
  
    private
    def auth
        request.env['omniauth.auth']
    end
end
