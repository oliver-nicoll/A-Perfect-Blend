class ProductsController < ApplicationController
    def search
        @products = Product.search(params[:product_name])
        render :index
    end

    def index

        if current_user && current_user.vendor?
            @products = current_user.products
        else
            @products = Product.all
        end
    end

    def show
        @product = Product.find_by(id: params[:id])
    end
    
    def new
        redirect_if_not_logged_in_as_vendor_or_admin
        @product = Product.new
    end
    
    def create
        redirect_if_not_logged_in_as_vendor_or_admin

        @product = Product.new(product_params)

        set_vendor_id_to_new_product
        
        if @product.save
            redirect_to products_path(@product)
        else
            flash[:message] = "Product not saved, try again"
            render :new
        end
    end

    def edit
        redirect_if_not_logged_in_as_vendor_or_admin
        @product = Product.find_by(id: params[:id])
    end
    
    def update
        redirect_if_not_logged_in_as_vendor_or_admin

        @product = Product.find_by(id: params[:id])
        @product.update(product_params)
        
        if @product.valid?
            redirect_to product_path(@product)
        else 
            flash[:message] = "Product not valid"
            render :edit
        end
    end
    
    def add_to_cart
        id = params[:id].to_i
        session[:cart] << product_params
        redirect_to products_path
    end

    def delete_cart_item
        id = params[:id].to_i
        session[:cart].destroy 
        redirect_to products_path
    end

      private

        def product_params
          params.require(:product).permit(
            :product_name,
            :product_description,
            :sold_at,
            :instock,
            :image,
            :category,
            :vendor_id
          )
        end
end
