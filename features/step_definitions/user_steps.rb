require './test/contexts'
include Contexts

Given /^an initial setup$/ do
  # context used for phase 3 only
  create_customers
  create_addresses
  create_orders
  # update order dates to fixed values
  @alexe_o1.update_attribute(:date, Date.new(2019,2,14))
  @alexe_o2.update_attribute(:date, Date.new(2019,2,17))
  @alexe_o3.update_attribute(:date, Date.new(2019,2,10))
  @melanie_o1.update_attribute(:date, Date.new(2019,2,17))
  @melanie_o2.update_attribute(:date, Date.new(2019,2,10))
  @anthony_o1.update_attribute(:date, Date.new(2019,2,17))
  # update alexe's email and created_at to 2018
  @alexe.update_attribute(:email, "alex.egan@example.com")
  @alexe.update_attribute(:created_at, Date.new(2018,2,17))
end

Given /^no setup yet$/ do
  # assumes initial setup already run as background
  destroy_orders
  destroy_addresses
  destroy_customers
end
