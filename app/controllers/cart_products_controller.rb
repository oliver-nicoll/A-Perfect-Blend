class CartProductsController < ApplicationController
    include CartsHelper

    before_action :set_cart_product, only: [:show, :edit, :update, :destroy]
    before_action :set_cart, only: [:create]
    

    def index 
        @cart_products = current_user.cart.cart_products.all
    end

    def show
        @cart_product = CartProduct.find(id: params[:product_id])
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
            redirect_to products_path(@cart_product), success: "Updated!"
        else
            redirect_to products_path, danger: "Try Again"
        end
    end

    def update
        @cart_product = @cart.cart_products.find(params[:id])
        @cart_product.update(cart_product_params)
            if @cart_product.valid?
                redirect_to cart_product_path, success: "Updated!"
            else
                render edit_cart_cart_product_path, danger: "Try Again!"
            end
    end

   def destroy
        @cart_product = CartProduct.find(params[:id])
        @cart_product.destroy
        redirect_to root_path, success: "Cart Product Deleted!"
   end

   def add_to_cart
   
    @product = Product.find_by(id: params[:product_id])
        cart = current_user.cart || current_user.create_cart
        if !cart.products.include?(@product)
            CartProduct.create(cart_id: cart.id, product_id: @product.id)
        else
            cart_product = cart.cart_products.find_by(product_id: @product.id)
            cart_product.quantity = cart_product.quantity += 1
            cart_product.save
            
        end
        redirect_to products_path, success: "Added to cart!"
    end
     
    def cart_pg_add_product
        @product = Product.find_by(id: params[:product_id])
        cart = current_user.cart || current_user.create_cart
        if !cart.products.include?(@product)
            CartProduct.create(cart_id: cart.id, product_id: @product.id)
        else
            cart_product = cart.cart_products.find_by(product_id: @product.id)
            cart_product.quantity = cart_product.quantity += 1
            cart_product.save
            
        end
        redirect_to carts_path, success: "Added to cart!"
    end

  
def delete_cart_product
    @product = Product.find_by(id: params[:product_id])
    cart = current_user.cart
    @cart_product = cart.cart_products.find_by(product_id: @product.id)
       if @cart_product.quantity > 1
            @cart_product.quantity -= 1
            @cart_product.save
       else
        @cart_product.destroy
    end
    
    redirect_to carts_path, success: "Deleted from cart!"
end

def total_price_cp
    product = Product.find_by(id: params[:product_id])
    cart = current_user.cart
    # @cart_product = cart.cart_products.find_by(product_id: product.id)
    total = cart.quantity * cart.product.sold_at
    return total
end
    
    private

    def set_cart_product
        @cart_product = CartProduct.find(params[:id])
        if @cart_product.nil?
            current_user.cart.create
        end
    end
    
    def cart_product_params
        params.require(:cart_products).permit(
        :cart_id,
        :product_id,
        :quantity
        )
    end

end
