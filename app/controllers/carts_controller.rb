class CartsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
    before_action :set_cart, only: [:show, :edit, :update, :destroy]
    def new
        @cart = Cart.new
    end


    def create
        @cart = Cart.new(cart_params)

        if @cart.save 
            redirect_to cart_path(@cart)
        else
            render :new
        end
    end

    def index
        @cart = Cart.all
    end

    def show
        @cart = Cart.find(params[:id])
    end

    def edit 

    end

    def destroy
        @cart.destroy if @cart.id === session[:cart_id]
        session[:cart_id] = nil

        redirect_to root_path
    end

    def checkout

    end

    private 
    def cart_params
        params.require(:cart).permit(:user_id, :checkout)
    end

    def invalid_cart
        logger.error "Attempt to access invalid cart #{params[:id]}"
        redirect_to root_path, notice: "That cart doesn't exist"
    end
end
