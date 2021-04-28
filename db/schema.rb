# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_28_015854) do

  create_table "cart_products", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "vendor_id", null: false
    t.integer "product_id", null: false
    t.integer "cart_id"
    t.integer "quantity", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cart_id"], name: "index_cart_products_on_cart_id"
    t.index ["customer_id"], name: "index_cart_products_on_customer_id"
    t.index ["product_id"], name: "index_cart_products_on_product_id"
    t.index ["vendor_id"], name: "index_cart_products_on_vendor_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "customer_id"
    t.boolean "checkout"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "customer_vendors", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "vendor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_customer_vendors_on_customer_id"
    t.index ["vendor_id"], name: "index_customer_vendors_on_vendor_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "product_name"
    t.string "product_description"
    t.integer "sold_at"
    t.integer "instock"
    t.string "image"
    t.string "vendor_name"
    t.string "category"
    t.integer "vendor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "role"
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "cart_products", "products"
  add_foreign_key "cart_products", "users", column: "customer_id"
  add_foreign_key "cart_products", "users", column: "vendor_id"
  add_foreign_key "customer_vendors", "users", column: "customer_id"
  add_foreign_key "customer_vendors", "users", column: "vendor_id"
end
