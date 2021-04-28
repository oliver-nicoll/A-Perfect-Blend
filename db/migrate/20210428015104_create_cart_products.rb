class CreateCartProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_products do |t|
      t.references :customer, null: false, foreign_key: {to_table: :users}
      t.references :vendor, null: false, foreign_key: {to_table: :users}
      t.references :product, null: false, foreign_key: true 
      t.references :cart
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
