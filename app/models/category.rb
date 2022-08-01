class Category < ApplicationRecord
    has_and_belongs_to_many :products
    def to_s
        name
    end

end
