require 'minitest/autorun'

require_relative '../products'

class TestProducts < Minitest::Test
  def setup
    @products_list = {mug: 5}
  end

  def test_load_products_list
    products = Products.new(@products_list)
    product = products.find(:mug)
    assert_equal(product.price, 5)
  end

  def test_register_new_product
    products = Products.new(@products_list)
    products.register_product("PEN", 10)
    assert_equal(products.find(:pen).price, 10)
  end


  def test_find_product_that_doesnt_exist
    assert_raises(ProductNotFound) do
      products = Products.new(@products_list)
      products.find(:nonproduct)
    end
  end
end
