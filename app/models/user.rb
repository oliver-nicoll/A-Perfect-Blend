class User < ApplicationRecord
    has_secure_password
    
    #customer
    has_many :cart_products, foreign_key: :customer_id
    has_many :products, through: :cart_products, source: :cart
    # has_many :products, through: :cart
    has_many :customer_vendors, foreign_key: :customer_id
    has_many :vendors, -> {where("users.role = ?", User.roles[:vendor])}, through: :customer_vendors, source: :vendor
    has_one :cart

    #vendor
    has_many :owned_products, foreign_key: :customer_id, class_name: "Product"
    has_many :customer_vendors, class_name: "CustomerVendor", foreign_key: :vendor_id
    has_many :customers, -> {where("users.role = ?", User.roles[:customer])}, through: :customer_vendors, source: :customer
    # has_many :products, through: :cart
    
    enum role: [:customer, :vendor, :admin]

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :name, length: { minimum: 2 }
    validates :password, length: { in: 6..20 }
    validates :vendor, inclusion: [true, false]
end
