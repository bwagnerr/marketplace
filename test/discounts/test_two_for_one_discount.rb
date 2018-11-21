require 'minitest/autorun'

require_relative '../../discounts/two_for_one_discount'
require_relative '../../cart'
require_relative '../../products'

class TestTwoForOneDiscount < Minitest::Test
  def setup
    products_list = {mug: 5}
    products = Products.new(products_list)
    @cart = Cart.new(products)
    @mug = products.find('MUG')
  end

  def test_apply_discount_with_even_products
    @cart.add('MUG')
    @cart.add('MUG')
    discount = TwoForOneDiscount.new(@mug)
    assert_equal(5, discount.for(@cart))
  end


  def test_apply_discount_with_odd_number_of_products
    @cart.add('MUG')
    @cart.add('MUG')
    @cart.add('MUG')
    discount = TwoForOneDiscount.new(@mug)
    assert_equal(5, discount.for(@cart))
  end
end
