require 'minitest/autorun'

require_relative '../cart'
require_relative '../products'

class TestCart < Minitest::Test
  def setup
    @products_list = {
      voucher: 5,
      tshirt: 10,
      mug: 15
    }
    @products = Products.new(@products_list)
  end

  def test_add_products_to_cart
    cart = Cart.new(@products)
    cart.add('VOUCHER')
    cart.add('TSHIRT')
    assert_equal(15, cart.sum)
  end

  def test_return_quantity_for_cart_items
    cart = Cart.new(@products)
    cart.add('MUG')
    cart.add('MUG')
    cart.add('MUG')
    assert_equal(3, cart.quantity(:mug))
  end
end
