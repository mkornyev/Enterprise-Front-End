# require needed files
require './test/sets/orders'
require './test/sets/customers'
require './test/sets/addresses'


module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::Orders
  include Contexts::Customers
  include Contexts::Addresses


  def create_all
    create_customers
    puts "Built customers"
    create_addresses
    puts "Built addresses for customers"
    create_orders
    puts "Built orders"
  end
end

