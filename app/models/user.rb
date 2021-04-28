class User < ApplicationRecord
    has_secure_password
    
    #customer
    # has_many :cart_products, foreign_key: :customer_id
    # has_many :products, through: :cart_products, source: :cart
    # has_one :cart
    has_many :carts
    has_many :products, through: :carts
    # has_many :, foreign_key: :customer_id
    # has_many :vendors, -> {where("users.role = ?", User.roles[:vendor])}, source: :user
    

    #vendor
    
    # has_many :products
    # has_many :customer_vendors, class_name: "CustomerVendor", foreign_key: :vendor_id
    # has_many :customers, -> {where("users.role = ?", User.roles[:customer])}, through: :customer_vendors, source: :user
    # has_many :products, through: :cart
    
    enum role: [:customer, :vendor, :admin]
    #index based 0, 1 ,2

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :name, length: { minimum: 2 }
    validates :password, length: { in: 6..20 }
    validates :vendor, inclusion: [true, false]
end
