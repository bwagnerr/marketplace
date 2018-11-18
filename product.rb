class ProductNotFound < StandardError; end

class Product
  PRICE_LIST = {
    voucher: 5,
    tshirt: 20,
    mug: 7.5
  }

  def initialize(identifier)
    @identifier = identifier.downcase.to_sym
  end

  def identifier
    @identifier
  end

  def price
    product_price = PRICE_LIST[@identifier]
    raise ProductNotFound unless product_price
    product_price
  end
end
