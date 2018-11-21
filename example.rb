require 'yaml'
require_relative 'checkout'

pricing = YAML.load_file('prices.yml')

discount_rules = YAML.load_file('discounts.yml')

co = Checkout.new(pricing, discount_rules)
co.scan('VOUCHER')
co.scan('TSHIRT')
co.scan('MUG')
puts co.pretty_print_total

co = Checkout.new(pricing, discount_rules)
co.scan('VOUCHER')
co.scan('VOUCHER')
co.scan('TSHIRT')
puts co.pretty_print_total

co = Checkout.new(pricing, discount_rules)
co.scan('TSHIRT')
co.scan('TSHIRT')
co.scan('TSHIRT')
co.scan('VOUCHER')
co.scan('TSHIRT')
puts co.pretty_print_total

co = Checkout.new(pricing, discount_rules)
co.scan('VOUCHER')
co.scan('TSHIRT')
co.scan('VOUCHER')
co.scan('VOUCHER')
co.scan('MUG')
co.scan('TSHIRT')
co.scan('TSHIRT')
puts co.pretty_print_total
