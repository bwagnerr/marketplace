require 'minitest/autorun'

require_relative '../../discounts/bulk_discount'
require_relative '../../cart'
require_relative '../../products'

class TestBulkDiscount < Minitest::Test
  def setup
    products_list = {mug: 5}
    products = Products.new(products_list)
    @cart = Cart.new(products)
    @mug = products.find('MUG')
  end

  def test_apply_bulk_discount_at_threshold
    @cart.add('MUG')
    @cart.add('MUG')
    discount = BulkDiscount.new(@mug, bulk_price: 4, bulk_threshold: 2)
    assert_equal(2, discount.for(@cart))
  end

  def test_apply_bulk_discount_above_quantity
    @cart.add('MUG')
    @cart.add('MUG')
    @cart.add('MUG')
    discount = BulkDiscount.new(@mug, bulk_price: 4, bulk_threshold: 2)
    assert_equal(3, discount.for(@cart))
  end

  def test_no_discount_below_bulk_quantity
    @cart.add('MUG')
    @cart.add('MUG')
    discount = BulkDiscount.new(@mug, bulk_price: 3, bulk_threshold: 3)
    assert_equal(0, discount.for(@cart))
  end
end
