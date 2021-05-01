class Cart < ApplicationRecord
    
    belongs_to :user
    has_many :cart_products, dependent: :destroy
    has_many :products, through: :cart_products
    before_save :set_cart_total

    # validates :completed, inclusion: [true, false]
    validates :user_id, numericality: { only_integer: true }

    def add_product(product)

        current_item = cart_products.find_by(product_id: product.id)

        if current_item
            binding.pry
            current_item.increment(:quantity, 1)
        else
            current_item = self.cart_products.build(product_id: product.id)
        end
        
        save 
        self
    end

    def delete_product(product)

        current_item = cart_products.find_by(product_id: product.id)

        current_item.decrement(:quantity, 1)
        
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
