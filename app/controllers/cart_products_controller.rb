class CartProductsController < ApplicationController
    include CurrentCart
    before_action :set_cart_product, only: [:show, :edit, :update, :destroy]
    before_action :set_cart, only: [:create]

    def index 
        @cart_products = current_user
    end

    def show
        
    end
    
    def new
        @cart_product = CartProduct.new
    end

    def edit

    end

    def create
        product = Product.find_by(params[:product_id])
        @cart = current_user.cart
            if @cart.nil?
                @cart = current_user.build_cart
            end
            @cart_product = @cart.add_product(product)
        if  @cart_product.save
            binding.pry
            redirect_to products_path(@cart_product)
        else
            flash[:message] = "Try Again!"
            render :new
        end
    end

    def update
        # @cart_product = CartProduct.find_by(id: params[:id])
        @cart_product = @cart.cart_products.find(params[:id])
        @cart_product.update(cart_product_params)
            if @cart_product.valid?
                redirect_to cart_product_path
            else
                flash[:message] = "Try Again!"
                render :edit
            end
    end

   def destroy
        # @cart = current_user.cart

        # @cart_product = @cart.cart_products.find(params[:id])
        
        @cart_product.destroy

        redirect_to root_path
   end

   def add_to_cart

    @product = Product.find_by(id: params[:product_id])
        cart = current_user.cart || current_user.create_cart
        
        cart.add_product(@product)
    
    redirect_to products_path
end

# def delete_cart_item
#     @product = Product.find_by(id: params[:product_id])
#     cart = current_user.cart(@product)
        
#     cart.cart_product.destroy
# end
    
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
