class User < ApplicationRecord
    has_secure_password
    
    has_many :products, foreign_key: :vendor_id, dependent: :destroy
    has_one :cart
    has_many :order_products, through: :cart, source: :products
   
    
    enum role: [:customer, :vendor, :admin]
    #index based 0, 1 ,2
    

    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :name, length: { minimum: 2 }
    # validates :password, length: { in: 4..20 }
    validates :password, confirmation: { case_sensitive: true }
    # validates :role, presence: true


end
