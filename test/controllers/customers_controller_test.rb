require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = FactoryBot.create(:customer)
  end

  test "should get index" do
    get customers_path
    assert_response :success
    assert_not_nil assigns(:active_customers)
    assert_not_nil assigns(:inactive_customers)
  end

  test "should get new" do
    get new_customer_path
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post customers_path, params: { customer: { first_name: "Ted", last_name: @customer.last_name, email: "tgruberman@example.com", phone: "412-268-2323", active: true } }
    end
    assert_equal "Ted Gruberman was added to the system.", flash[:notice]
    assert_redirected_to customer_path(Customer.last)

    post customers_path, params: { customer: { first_name: "Ted", last_name: nil, email: "tgruberman@example.com", phone: "412-268-2323", active: true } }
    assert_template :new
  end

  test "should show customer" do
    get customer_path(@customer)
    assert_response :success
    assert_not_nil assigns(:previous_orders)
  end

  test "should get edit" do
    get edit_customer_path(@customer)
    assert_response :success
  end

  test "should update customer" do
    patch customer_path(@customer), params: { customer: { first_name: @customer.first_name, last_name: @customer.last_name, email: "eddie@example.com", phone: @customer.phone, active: @customer.active } }
    assert_redirected_to customer_path(@customer)

    patch customer_path(@customer), params: { customer: { first_name: @customer.first_name, last_name: nil, email: "eddie@example.con", phone: @customer.phone, active: @customer.active } }
    assert_template :edit
  end

end