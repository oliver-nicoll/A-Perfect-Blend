class CreateCustomerVendors < ActiveRecord::Migration[6.1]
  def change
    create_table :customer_vendors do |t|
      t.references :customer, null: false, foreign_key: {to_table: :users}
      t.references :vendor, null: false, foreign_key: {to_table: :users}
      
      t.timestamps
    end
  end
end
