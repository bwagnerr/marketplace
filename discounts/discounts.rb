require_relative 'two_for_one_discount'
require_relative 'bulk_discount'

class DiscountTypeNotFound < StandardError; end

class MissingDiscountInformation < StandardError; end

class Discounts
  def initialize(discount_rules, products)
    @discounts = discount_rules.map do |rule|
      product = products.find(rule[:product])
      case rule[:type]
      when :two_for_one
        create_two_for_one(product, rule)
      when :bulk
        create_bulk(product, rule)
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

  def create_bulk(product, rule)
    bulk_price = rule[:bulk_price]
    bulk_threshold = rule[:bulk_threshold]
    raise MissingDiscountInformation unless bulk_threshold && bulk_price
    BulkDiscount.new(product, bulk_price: rule[:bulk_price],
                     bulk_threshold: rule[:bulk_threshold])
  end

  def create_two_for_one(product, rule)
    TwoForOneDiscount.new(product)
  end

  def list
    @discounts
  end
end
