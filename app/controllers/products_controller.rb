class ProductsController < ApplicationController
    def search
        @products = Product.search(params[:product_name])
        render :index
    end

    def index
        @products = Product.all.order("product_name")
    end

    def show
        @product = Product.find_by(id: params[:id])
        @product.update(@product.instock)
    end
    
    def new
        redirect_if_not_logged_in
        @product = Product.new
    end
    
    def create
        redirect_if_not_logged_in
        @product = Product.new(product_params)

        if @product.save
            redirect_to products_path(@product)
        else
            #flash message
            render :new
        end
    end

    def edit
        redirect_if_not_logged_in
        @product = Product.find_by(id: params[:id])
    end
    
    def update
        @product = Product.find_by(id: params[:id])
        @product.update(product_params)
        
        if @product.valid?
            redirect_to product_path(@product)
        else 
            #flash message
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
        session[:cart] << product_params
        redirect_to products_path
    end

    def vendor_products
        binding.pry
        @products = Product.find_by(vendor_id: params[:vendor_id])
    end

      private

        def product_params
          params.require(:product).permit(
            :vendor_name,
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
