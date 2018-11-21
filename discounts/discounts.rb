require_relative 'two_for_one_discount'
require_relative 'bulk_discount'

class DiscountTypeNotFound < StandardError; end

class Discounts
  def initialize(discount_rules, products)
    @discounts = discount_rules.map do |rule|
      product = products.find(rule[:product])
      case rule[:type]
      when :two_for_one
        TwoForOneDiscount.new(product)
      when :bulk
        BulkDiscount.new(product, bulk_price: rule[:bulk_price],
                         bulk_threshold: rule[:bulk_threshold])
      else
        raise DiscountTypeNotFound
      end
    end
  end

  def apply(cart)
    @discounts.inject(0) do |value, discount|
      value + discount.for(cart)
    end
  end

  def list
    @discounts
  end
end
