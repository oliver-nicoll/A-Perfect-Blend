class SessionsController < ApplicationController
    def new

    end
  
    def create
        @user = User.find_by_username(params[:user][:username])
  
        if @user && @user.authenticate(params[:user][:password])
            flash[:message] = "Succesful sign in"
            session[:user_id] = @user.id
            redirect_to root_path
        else
            flash[:message] = "Invalid, try again"
            render :new
        end
    end
  
    def logout
      session.clear
      redirect_to login_path
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
        #  binding.pry
          if @user.valid?
              flash[:messsage] = "Signed in with Google"
              session[:user_id] = @user.id
              redirect_to root_path
          else
              flash[:message] = "Try Again - Not Valid"
              redirect_to login_path
          end
      end
  
    private
    def auth
        request.env['omniauth.auth']
    end
end
