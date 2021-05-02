class Cart < ApplicationRecord
    
    belongs_to :user
    has_many :cart_products, dependent: :destroy
    has_many :products, through: :cart_products
    before_save :set_cart_total

    # validates :completed, inclusion: [true, false]
    validates :user_id, numericality: { only_integer: true }

    
    # cart has many orders but order belongs to cart
    

    # def add_product(product)
        
    #     current_item = cart_products.find_by(product_id: product.id)

    #     if current_item
    #         current_item.increment(:quantity, 1)
    #     else
    #         current_item = self.cart_products.build(product_id: product.id)
    #         binding.pry
    #     end
        
    #     save 
    #     self
    # end

    # def delete_product(product)

    #     current_item = cart_products.find_by(product_id: product.id)

    #     current_item.decrement_counter(:quantity, 1)
        
    #     save 
    #     self
    # end


    def subtotal_cart
        sum = 0

        self.cart_products.each { |p| sum+= p.total_price }

        return sum 
        
    end

    private

    def set_cart_total

        self[:subtotal] = subtotal
    end
end
