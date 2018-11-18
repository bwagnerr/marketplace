require 'test/unit'
require_relative '../checkout'

class CheckoutTest < Test::Unit::TestCase

  def test_checkout_no_discounts
    checkout = Checkout.new
    checkout.scan('VOUCHER')
    checkout.scan('TSHIRT')
    checkout.scan('MUG')
    assert_equal(32.5, checkout.total)
  end
end
