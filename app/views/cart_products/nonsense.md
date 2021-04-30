 <div class="cart-products cart">
          <ul>
            <li>Quantity: <%= current_user.cart_products.quantity %></li>
              <figure> <%= image_tag(cart_product.product.image)%> </figure>
            <li> <%= cart_product.product.product_name %> - <%= cart_product.product.sold_at %></li>
            <li> Total: <%= number_to_currency(cart_product.subtotal_cart) %> </li>
          </ul>
        </div>