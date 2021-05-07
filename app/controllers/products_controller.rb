class ProductsController < ApplicationController
    before_action :find_user, only: [:index, :new, :create]
    before_action :redirect_if_not_logged_in_as_vendor_or_admin, only: [:new, :create, :edit, :update, :destroy ]
    
    
    def search
        @products = Product.search(params[:product_name])
        render :index
    end

    def index

        if @c_user 
            # @current_user = User.find(params[:user_id])
            @products = @c_user.products
        else
            @products = Product.all
        end
    end

    def show
        @product = Product.find_by(id: params[:id])
    end
    
    def new
        if @c_user
            @product = @c_user.products.build
        else
            @product = Product.new
            @product.build_user
        end

        #product = c_user.products.find_by(id: params[:product_id])
    end
    
    def create
        

        @product = current_user.products.build(product_params)


        if @product.save
            redirect_to products_path(@product)
        else
            
            redirect_to new_products_path, danger: "Product not saved, try again"
        end

        
    end

    def edit
        
        @product = Product.find_by(id: params[:id])
    end
    
    def update
        

        @product = Product.find_by(id: params[:id])
        @product.update(product_params)
        
        if @product.valid?
            redirect_to product_path(@product)
        else 
            redirect_to edit_product_path, danger: "Product not valid"
        end
    end

    def destroy
        

        @product = Product.find_by(id: params[:id])
        
        @product.destroy
        
        redirect_to products_path, info: "Product Deleted"
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

        def find_user
            @c_user = User.find_by_id(params[:user_id])
        end
end
