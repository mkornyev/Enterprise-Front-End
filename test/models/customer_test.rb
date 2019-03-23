require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:orders)
  should have_many(:addresses)

  # test simple validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)

  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)

  # rest with contexts
  context "Within context" do
    setup do 
      create_customers
    end
    
    teardown do
      destroy_customers
    end

    should "show that scope exists for alphabeticizing customers" do
      assert_equal ["Chen", "Corletti", "Egan", "Flood", "Freeman"], Customer.alphabetical.all.map(&:last_name)
    end

    should "show that there are four active customers and one inactive customer" do
      assert_equal ["Corletti", "Egan", "Flood", "Freeman"], Customer.active.all.map(&:last_name).sort
      assert_equal ["Chen"], Customer.inactive.all.map(&:last_name).sort
    end

    should "have working name methods" do
      assert_equal "Chen, Sherry", @sherry.name
      assert_equal "Melanie Freeman", @melanie.proper_name
    end

    should "strip non-digits from the phone number" do
      assert_equal "4122682323", @anthony.phone
    end    
  end
end