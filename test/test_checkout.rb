require 'minitest/autorun'

require_relative '../checkout'

class TestCheckout < Minitest::Test
  def setup
    @products_list = {
      tshirt: 20,
      voucher: 5,
      mug: 7.5
    }
    @discount_rules = [
      {type: :two_for_one, product: :voucher},
      {type: :bulk, product: :tshirt, bulk_threshold: 3, bulk_price: 19}
    ]
  end

  def test_checkout_no_discounts
    checkout = Checkout.new(@products_list, @discount_rules)
    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')
    checkout.scan('MUG')
    assert_equal(32.5, checkout.total)
  end

  def test_checkout_with_two_for_one_discount
    checkout = Checkout.new(@products_list, @discount_rules)
    checkout.scan('VOUCHER')
    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')
    assert_equal(25, checkout.total)
  end

  def test_checkout_with_bulk_discount
    checkout = Checkout.new(@products_list, @discount_rules)
    checkout.scan('TSHIRT')
    checkout.scan('TSHIRT')
    checkout.scan('TSHIRT')
    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')
    assert_equal(81, checkout.total)
  end

  def test_checkout_multiple_discounts
    checkout = Checkout.new(@products_list, @discount_rules)
    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')
    checkout.scan('VOUCHER')
    checkout.scan('VOUCHER')
    checkout.scan('MUG')
    checkout.scan('TSHIRT')
    checkout.scan('TSHIRT')
    assert_equal(74.5, checkout.total)
  end
end
