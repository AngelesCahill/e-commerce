require "test_helper"

class CartTest < ActiveSupport::TestCase
  validates :number, uniqueness: true
  test "the truth" do
    assert true
  end
  test 'creates a random number on create' do
    user = User.create(email: "first_user@example.com", password: "12345678")
    order = Order.create(user_id: user.id)
    assert !order.number.nil?
  end
  def generate_number
    self.number ||= loop do
    random = "BO#{Array.new(9){rand(9)}.join}"
    break random unless self.class.exists?(number: random)
  end
  test 'creates a random number on create' do
    user = User.create(email: "user@example.com", password: "12345678")
    cart = Cart.create(user_id: user.id)
    assert !cart.number.nil?
  end
  test 'number must be unique' do
    user = User.create(email: "user@example.com", password: "12345678")
    cart = Cart.create(user_id: user.id)
    duplicated_order = Cart.dup
    assert_not duplicated_order.valid?
  end
  test 'add product as order_items' do
    user = User.create(email: "user@example.com", password: "12345678")
    cart = Cart.create(user_id: user.id)
    product = Product.create(name: "test", price: 1, stock: 10, sku:
    "001")
    cart.add_product(product.id, 1)
    assert_equal cart.current_orders.count, 1
  end

  test 'products with stock zero cant be added to cart' do
    user = User.create(email: "user@example.com", password: "12345678")
    cart = Cart.create(user_id: user.id)
    product = Product.create(name: "test", price: 1, stock: 0, sku:
    "001")
    cart.add_product(product.id, 1)
    assert_equal cart.current_orders.count, 0
  end


end



