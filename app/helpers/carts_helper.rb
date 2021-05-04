module CartsHelper

    def subtotal_cart
        sum = 0

        self.cart_products.each { |p| sum+= p.total_price }

        return sum 
        
    end
end
