class CreateCartProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_products do |t|
      t.references :user, foreign_key: {on_delete: :cascade}
      t.references :product, null: false, foreign_key: {on_delete: :cascade}
      t.references :cart, null: false, foreign_key: {on_delete: :cascade}
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
