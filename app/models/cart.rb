class Cart < ApplicationRecord
    
    belongs_to :user
    has_many :cart_products, dependent: :destroy
    has_many :products, through: :cart_products
    before_save :set_cart_total

    # validates :completed, inclusion: [true, false]
    validates :user_id, numericality: { only_integer: true }

    
    # cart has many orders but order belongs to cart
    
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
