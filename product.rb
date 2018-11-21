class ProductNotFound < StandardError; end

class Product
  attr_reader :identifier, :price

  def initialize(identifier, price)
    @identifier = identifier
    @price = price
  end
end
