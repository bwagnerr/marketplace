require 'minitest/autorun'

require_relative '../product'

class TestProduct < Minitest::Test
  def test_product_has_an_identifier
    product = Product.new(:mug, 15)
    assert_equal(:mug, product.identifier)
  end

  def test_product_has_a_price
    product = Product.new(:voucher, 10)
    assert_equal(10, product.price)
  end
end
