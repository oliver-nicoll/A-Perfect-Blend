class CartProduct < ApplicationRecord
    belongs_to :cart 
    belongs_to :product
    
#     has_one :user, through: :cart
    
    

    validates :product_id, numericality: { only_integer: true }
    validates :cart_id, numericality: { only_integer: true }
    validates :quantity, numericality: { only_integer: true }

   def total_price

        self.quantity * self.product.sold_at
   end
end
