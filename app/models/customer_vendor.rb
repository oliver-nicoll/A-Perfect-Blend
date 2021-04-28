class CustomerVendor < ApplicationRecord
    belongs_to :customer, class_name: "User"
    belongs_to :vendor, class_name: "User"
end
