class ProductsController < ApplicationController
    def search
        @products = Product.search(params[:product_name])
        render :index
    end

    def index
        if params[:user_id]
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

        @product = current_user.products.build(product_params)


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

    def destroy
        redirect_if_not_logged_in_as_vendor_or_admin

        @product = Product.find_by(id: params[:id])
        
        @product.destroy
        
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
          )
        end
end
