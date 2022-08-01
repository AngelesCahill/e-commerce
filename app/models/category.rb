class Category < ApplicationRecord
    has_and_belongs_to_many :productss
    def to_s
        name
    end

end
