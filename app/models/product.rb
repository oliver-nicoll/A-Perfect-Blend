class Product < ApplicationRecord
    # before_destroy :not_referenced_by_any_cart_product
    
    belongs_to :vendor, :class_name => "User", :foreign_key => "vendor_id"
     
    has_many :cart_products, dependent: :destroy
    has_many :carts, through: :cart_products
    has_many :users, through: :carts
   



    validates :product_name, presence: true, uniqueness: {scope: :image, message: 'and Image Url are not UNIQUE'}
    validates :product_description, :instock, presence: true 
    validates :sold_at, numericality: { only_integer: true, greater_than_or_equal_to: 0}
    
    

    scope :search, -> (query) { self.where("product_name LIKE ?", "%#{query}%") }
    
    CATEGORY = %w{ Candle Decor Jewelry Food Furniture Soap Other }

    
    def not_referenced_by_any_cart_product
        unless cart_products.empty?
            errors.add(:base, "Cart products present")
            throw :abort
        end
    end
end
