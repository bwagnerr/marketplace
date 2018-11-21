class BulkDiscount
  def initialize(product, bulk_price:, bulk_threshold:)
    @product = product
    @bulk_price = bulk_price
    @bulk_threshold = bulk_threshold
  end

  def for(cart)
    return 0 unless eligible_for_discount(cart)
    cart.items.inject(0) do |total, product|
      discount = (product.identifier == @product.identifier) ? product.price - @bulk_price : 0
      total + discount
    end
  end

  def eligible_for_discount(cart)
    cart.quantity(@product.identifier) >= @bulk_threshold
  end
end
