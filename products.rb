require_relative 'product'

class ProductNotFound < StandardError; end

class Products
  def initialize(product_list)
    @products = {}
    product_list.each_pair do |identifier, price|
      register_product(identifier, price)
    end
  end

  def register_product(identifier, price)
    normalized_identifier = identifier.to_sym.downcase
    @products[normalized_identifier] = Product.new(normalized_identifier, price)
  end

  def find(identifier)
    product = @products[identifier.to_sym.downcase]
    raise ProductNotFound unless product
    product
  end
end
