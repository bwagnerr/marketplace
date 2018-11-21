require_relative 'products'
require_relative 'cart'
require_relative 'discounts/discounts'

class Checkout

  def initialize(pricing, discount_rules)
    @products = Products.new(pricing)
    @cart = Cart.new(@products)
    @discounts = Discounts.new(discount_rules, @products)
  end

  def scan(product)
    @cart.add(product)
  end

  def total
    @cart.sum - @discounts.apply(@cart)
  end

  def pretty_print_total
    puts "Items: #{ @cart.items.map { |item| item.identifier }.join(', ') }"
    puts "Total: #{ sprintf('%.2f', total) }€"
  end
end
