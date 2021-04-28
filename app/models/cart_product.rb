class CartProduct < ApplicationRecord
    belongs_to :cart 
    belongs_to :user
    belongs_to :customer,  class_name: "User"
    belongs_to :vendor,  class_name: "User"
    belongs_to :product

    validates :product_id, numericality: { only_integer: true }
    validates :cart_id, numericality: { only_integer: true }
    validates :quantity, numericality: { only_integer: true }

    def cart_total
        product.sold_at.to_i * quantity.to_i
    end
end
