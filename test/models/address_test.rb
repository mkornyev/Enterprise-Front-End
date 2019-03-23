require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:customer)
  should have_many(:orders)

  # test validations with matchers
  should validate_presence_of(:recipient)
  should validate_presence_of(:street_1)
  should validate_presence_of(:zip)
  should validate_inclusion_of(:state).in_array(Address::STATES_LIST.to_h.values)

  should allow_value("12345").for(:zip)
  should_not allow_value("1234").for(:zip)
  should_not allow_value("123456").for(:zip)
  should_not allow_value("12345-0001").for(:zip)
  should_not allow_value("1234I").for(:zip)
  should_not allow_value(nil).for(:zip)

  context "Within context" do
    setup do 
      create_customers
      create_addresses
    end
    
    teardown do
      destroy_addresses
      destroy_customers
    end

    should "show that by_recipient places addresses in alphabetical order" do
      assert_equal ["Alex Egan", "Anthony Corletti", "Jeff Egan", "Melanie Freeman", "Ryan Flood", "Zach Egan"], Address.by_recipient.all.map(&:recipient)
    end

    should "show that by_customer places addresses in alphabetical order by customer" do
      assert_equal ["Anthony Corletti", "Alex Egan", "Jeff Egan", "Zach Egan", "Ryan Flood", "Melanie Freeman"], Address.by_customer.by_recipient.all.map(&:recipient)
    end

    should "show that there are two active addresses and one inactive address" do
      assert_equal 5, Address.active.all.count
      assert_equal ["Zach Egan"], Address.inactive.all.map(&:recipient).sort
    end

    should "show that scopes for billing and shipping" do
      assert_equal ["Alex Egan", "Anthony Corletti", "Melanie Freeman", "Ryan Flood"], Address.billing.all.map(&:recipient).sort
      assert_equal ["Jeff Egan", "Zach Egan"], Address.shipping.all.map(&:recipient).sort
    end

    should "verify that the customer is active in the system" do
      # test the inactive customer first
      bad_address = FactoryBot.build(:address, customer: @sherry, recipient: "Sherry Chen", is_billing: true, active: true)
      deny bad_address.valid?
      # test the nonexistent customer
      ghost = FactoryBot.build(:customer, first_name: "Ghost")
      non_customer_address = FactoryBot.build(:address, customer: ghost)
      deny non_customer_address.valid?
    end 

    should "have a method alread_exists? to help identify duplicate addresses" do
      # create a copy of an existing address
      old_address = FactoryBot.build(:address, customer: @alexe, recipient: "Jeff Egan", is_billing: false, zip: "15212")
      assert old_address.already_exists?
      # build a new address same as above but now belongs to Melanie instead of Alex (so not a duplicate)
      new_address = FactoryBot.build(:address, customer: @melanie, recipient: "Jeff Egan", is_billing: false, zip: "15212")
      deny new_address.already_exists?
    end

    should "verify customer's address for this recipient is not already in the system" do
      bad_address = FactoryBot.build(:address, customer: @alexe, recipient: "Jeff Egan", is_billing: false, zip: "15212")
      deny bad_address.valid?
    end 

    should "allow an address 'duplication' if it belongs to a different customer" do
      # same address as before, but belongs now to Melanie instead of Alex
      good_address = FactoryBot.build(:address, customer: @melanie, recipient: "Jeff Egan", is_billing: false, zip: "15212")
      assert good_address.valid?
    end
  end
end