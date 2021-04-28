class Cart < ApplicationRecord
    # belongs_to :product
    # belongs_to :customer, class_name: "User"
    has_many :cart_products, dependent: :destroy
    has_many :products, through: :cart_products
    belongs_to :customer,  class_name: "User"

    validates :checkout, inclusion: [true, false]
    validates :user_id, numericality: { only_integer: true }

    def add_product(product)
        current_item = cart_products.find_by(product_id: product.id)

        if current_item
            current_item.increment(:quantity)
        else
            current_item = cart_products.build(product_id: product.id)
        end
        current_item
    end

    def cart_total
        cart_products.to_a.sum { |p| p.cart_total }
    end
end
