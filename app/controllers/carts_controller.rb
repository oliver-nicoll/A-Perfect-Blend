class CartsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
    before_action :set_cart, only: [:show, :edit, :update, :destroy]
    
    
    def index
    
        @cart = current_user.cart.cart_products.all 
        
    end

    def show
        @cart = @current_cart
    end

    
    def new
        @cart = Cart.new
    end


    def create
        @cart = Cart.new(cart_params)

        if @cart.save 
            current_user.id = user_id
            redirect_to cart_path(@cart)
        else
            render :new
        end
    end

    def edit 

    end

    def update
        @cart = Cart.find_by(id: params[:id])
        @cart.update(cart_params)

            if @cart.valid?
                redirect_to cart_path
            else
                flash[:message] = "Try Again!"
                render :edit
            end
    end

    def destroy
        @cart = current_user.cart
        
        @cart.destroy

        redirect_to root_path
    end

    def checkout
        
    end

    private 
    def cart_params
        params.require(:cart).permit(:user_id, :completed)
    end

    def invalid_cart
        logger.error "Attempt to access invalid cart #{params[:id]}"
        redirect_to root_path, notice: "That cart doesn't exist"
    end
end
