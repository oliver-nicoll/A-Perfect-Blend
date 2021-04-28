class CartProductsController < ApplicationController
    before_action :set_cart_product, only: [:show, :edit, :update, :destroy]
    before_action :set_cart, only: [:create]

    def index 
        @cart_products = CartProduct.all
    end
    
    def new
        @cart_product = CartProduct.new
    end

    def create
        product = Product.find(params[:product_id])

        @cart_product = @cart.add_product(product)

        if  @cart_product.save
            #message = add a flash message here
            redirect_to products_path
        else
            #flash message
            render :new
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
