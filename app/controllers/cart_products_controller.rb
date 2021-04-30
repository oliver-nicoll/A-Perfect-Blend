class CartProductsController < ApplicationController
    include CurrentCart
    before_action :set_cart_product, only: [:show, :edit, :update, :destroy]
    before_action :set_cart, only: [:create]

    def index 
        @cart_products = CartProduct.all
    end

    def show
        
    end
    
    def new
        @cart_product = CartProduct.new
    end

    def edit

    end

    def create
        product = Product.find(params[:product_id])

        @cart_product = @cart.add_product(product)

        if  @cart_product.save
            redirect_to products_path(@cart_product)
        else
            flash[:message] = "Try Again!"
            render :new
        end
    end

    def update
        @cart_product = CartProduct.find_by(id: params[:id])
        @cart_product.update(cart_product_params)
            if @cart_product.valid?
                redirect_to cart_product_path
            else
                flash[:message] = "Try Again!"
                render :edit
            end
    end

   def destroy
        @cart = Cart.find(session[:cart_id])

        @cart_product.destroy

        redirect_to root_path
   end
    
    private

    def set_cart_product
        @cart_product = CartProduct.find(params[:id])
    end
    
    def cart_product_params
        params.require(:cart_products).permit(
        :cart_id,
        :product_id,
        :vendor_id,
        :quantity
        )
    end

end
