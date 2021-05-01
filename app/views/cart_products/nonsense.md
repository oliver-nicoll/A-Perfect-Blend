 <div class="cart-products cart">
          <ul>
            <li>Quantity: <%= current_user.cart_products.quantity %></li>
              <figure> <%= image_tag(cart_product.product.image)%> </figure>
            <li> <%= cart_product.product.product_name %> - <%= cart_product.product.sold_at %></li>
            <li> Total: <%= number_to_currency(cart_product.subtotal_cart) %> </li>
          </ul>
        </div>



index - carts

        <div class: 'columns'>
              <div class: 'column'>
                  <%= button_to 'Empty Cart', @cart, method: :delete, data: { confirm: 'Are you sure?'} %>
              </div>
          <h4>
           <span>Total:</span> <%= number_to_currency(@cart.subtotal_cart) %>
           </h4>