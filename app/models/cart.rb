class Cart < ApplicationRecord
  has_many :current_orders
  has_many :products, through: :current_orders
  has_many :payments
  validates :number, uniqueness: true

  before_create -> { generate_number(hash_size) }
  belongs_to :user

  def generate_number(size)
    self.number ||= loop do
      random = random_candidate(size)
      break random unless self.class.exists?(number: random)
    end
  end
  def random_candidate(size)
  "#{hash_prefix}#{Array.new(size){rand(size)}.join}"
  end

  def hash_prefix
  "BO"
  end

  def hash_size
  9
  end

  def add_product(product_id, quantity)
  product = Product.find(product_id)
    if product
      current_orders.create(product_id: product.id, quantity: quantity, price: product.price)
    end
  end

  def add_product(product_id, quantity)
    product = Product.find(product_id)
    if product && (product.stock > 0)
      current_orders.create(product_id: product.id, quantity: quantity, price: product.price)
    end
  end


end
