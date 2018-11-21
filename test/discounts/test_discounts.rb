require 'minitest/autorun'

require_relative '../../discounts/bulk_discount'
require_relative '../../discounts/two_for_one_discount'

class TestDiscounts < Minitest::Test
  def test_creates_discounts
    @discount_rules = [
      {type: :two_for_one, product: :voucher},
      {type: :bulk, product: :tshirt, bulk_threshold: 3, bulk_price: 19}
    ]
    discounts = Discounts.new(@discount_rules, [])
    assert_instance_of(TwoForOneDiscount, discounts.list.first)
    assert_instance_of(BulkDiscount, discounts.list.last)
  end

  def test_raises_error_on_missing_discount_info
    assert_raises(MissingDiscountInformation) do
      @discount_rules = [{type: :bulk, product: :mug}]
      discount = Discounts.new(@discount_rules, [])
    end
  end

  def test_raises_error_on_unrecognized_discount_type
    assert_raises(DiscountTypeNotFound) do
      @discount_rules = [{type: :free_above_threshold}]
      discount = Discounts.new(@discount_rules, [])
    end
  end
end
