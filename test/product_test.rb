require 'test/unit'
require_relative '../product'

class ProductTest < Test::Unit::TestCase

  def test_product_has_an_identifier
    product = Product.new('MUG')
    assert_equal(:mug, product.identifier)
  end

  def test_product_has_a_price
    product = Product.new('VOUCHER')
    assert(product.respond_to?(:price))
  end

  def test_different_product_prices
    voucher = Product.new('VOUCHER')
    assert_equal(5, voucher.price)

    tshirt = Product.new('TSHIRT')
    assert_equal(20, tshirt.price)
  end

  def test_product_doesnt_exist
    assert_raises(ProductNotFound) do
      product = Product.new('nonproduct')
      product.price
    end
  end
end
