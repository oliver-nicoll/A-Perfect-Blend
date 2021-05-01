module CurrentCart

    def current_order_cart
        if Cart.find_by_id(session[:cart_id]).nil?
            Cart.new
          else
            Cart.find_by_id(session[:cart_id])
          end

    end
  
    private

    def set_cart
            @cart = Cart.find(session[:cart_id])
        rescue ActiveRecord::RecordNotFound
            @cart = Cart.create
            session[:cart_id] = @cart.id
    end
end