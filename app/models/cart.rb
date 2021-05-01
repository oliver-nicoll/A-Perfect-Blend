class Cart < ApplicationRecord
    
    belongs_to :user
    has_many :cart_products, dependent: :destroy
    has_many :products, through: :cart_products
    before_save :set_cart_total

    # validates :completed, inclusion: [true, false]
    validates :user_id, numericality: { only_integer: true }

    
    
    def add_product(product)
        cart = @current_user.cart.find_by(cart_id: cart.id)
binding.pry
        current_item = cart.cart_products.find_by(product_id: product.id)
        
        if current_item
            current_item.increment_counter(:quantity, 1)

            current_item.save
        else
            current_item = self.cart.cart_products.build(product_id: product.id)
        end
        
        save 
        self
    end

    def delete_product(product)

        current_item = cart_products.find_by(product_id: product.id)

        current_item.decrement_counter(:quantity, 1)
        
        save 
        self
    end

     def cart_total

     binding.pry
        product.sold_at.to_i * quantity.to_i
    end


    def subtotal_cart
        cart_products.to_a.sum { |p| p.subtotal }
    end

    private

    def set_cart_total

        self[:subtotal] = subtotal
    end
end
