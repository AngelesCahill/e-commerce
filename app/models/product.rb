class Product < ApplicationRecord
    has_and_belongs_to_many :categories
    has_many :current_orders
    has_many :carts, through: :current_orders

end
