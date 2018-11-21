class TwoForOneDiscount
  def initialize(product)
    @product = product
  end

  def for(cart)
    eligible_quantity = (cart.quantity(@product.identifier) / 2).floor
    eligible_quantity * @product.price
  end
end
