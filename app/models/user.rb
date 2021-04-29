class User < ApplicationRecord
    has_secure_password
    
    has_many :products, foreign_key: :vendor_id
    has_many :carts
    has_many :order_products, through: :carts, source: :products
   
    
    enum role: [:customer, :vendor, :admin]
    #index based 0, 1 ,2

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :name, length: { minimum: 2 }
    validates :password, length: { in: 6..20 }
    validates :vendor, inclusion: [true, false]
    validates :role, presence: true

    
end
