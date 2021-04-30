class AddTotalToCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :total, :decimal
    add_column :carts, :subtotal, :decimal
  end
end
