# require needed files
require './lib/tasks/helpers/customers'
require './lib/tasks/helpers/addresses'
require './lib/tasks/helpers/orders'

module Populator  
  include Populator::Customers
  include Populator::Addresses
  include Populator::Orders
end