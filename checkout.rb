require_relative 'product'

class Checkout

  def initialize
    @cart = []
  end

  def scan(product)
    @cart << Product.new(product)
  end

  def total
    @cart.inject(0) do |sum, product|
      sum += product.price
    end
  end
end
