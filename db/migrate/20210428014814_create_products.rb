class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :product_description
      t.integer :sold_at
      t.integer :instock
      t.string :image
      t.string :category
      t.integer :vendor_id, foreign_key: {on_delete: :cascade}
      
      t.timestamps
    end
  end
end
