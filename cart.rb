require_relative 'products'

class Cart
  def initialize(product_list)
    @product_list = product_list
    @items = []
  end

  def add(item)
    @items << @product_list.find(item)
  end

  def quantity(identifier)
    @items.count do |item|
      item.identifier == identifier
    end
  end

  def items
    @items
  end

  def sum
    @items.inject(0) do |sum, item|
      sum + item.price
    end
  end
end
