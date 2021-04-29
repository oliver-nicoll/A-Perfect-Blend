




h = Product.create(product_name: 'Honey', product_description: "Local Keiner's Apiary wildflower honey", sold_at: 9, instock: 5, image: "https://ibb.co/z8dHQnh", category: "Food", vendor_id: 1)
Product.create(product_name: 'Honey Sticks', product_description: "Local Keiner's Apiary wildflower honey", sold_at: 1, instock: 25, image: "https://image.shutterstock.com/image-vector/realistic-liquid-honey-dripping-wooden-600w-1429748669.jpg", category: "Food", vendor_id: 1)
Product.create(product_name: 'Orangeade', product_description: "Fresh made orangade from A Perfect Blend", sold_at: 3, instock: 18, image: "https://images.unsplash.com/photo-1497534446932-c925b458314e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1307&q=80", category: "Drink", vendor_id: 2)


#vendor
User.create(role: 1,  username: "KeinerHA", name: "Harold Keiner", email: "keinerapiary@gmail.com", password: "password")
User.create(role: 1,  username: "coliver", name: "Christine Oliver", email: "test@btbm.com", password: "password")

#shopper
User.create(role: 0, username: "shopper", name: "Cathy Not Vendor", email: "test@test.com", password: "password")
User.create(role: 0, username: "test", name: "Delores Not Vendore", email: "test@t.com", password: "password" )
#admin
User.create(role: 2, username: "nicolldon", name: "Nicoll Oliver", email: "btbm@aperfectblend.com", password: "password" )

#cart
c = Cart.create(user_id: 3, completed: false)
c.cart_products.build(product: h, quantity: 3)
c.save


