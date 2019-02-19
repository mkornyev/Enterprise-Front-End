require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = FactoryBot.create(:customer)
    @address = FactoryBot.create(:address, customer: @customer)
    @order = FactoryBot.create(:order, customer: @customer, address: @address)
  end

  test "should get index" do
    get orders_path
    assert_response :success
    assert_not_nil assigns(:all_orders)
  end

  test "should get new" do
    get new_order_path
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_path, params: { order: { customer_id: @customer.id, address_id: @address.id, date: Date.current, grand_total: 6.53 } }
    end
    assert_equal "Thank you for ordering from the Baking Factory.", flash[:notice]
    assert_redirected_to order_path(Order.last)

    post orders_path, params: { order: { customer_id: nil, address_id: @address, date: Date.current, grand_total: 6.53 } }
    assert_template :new
  end
  
  test "should have date and payment set on orders#create" do
    assert_difference('Order.count') do
      post orders_path, params: { order: { customer_id: @customer.id, address_id: @address.id, date: nil, grand_total: 6.53 } }
    end
    assert_equal Date.current, Order.last.date
    refute_nil Order.last.payment_receipt, "payment_receipt: #{Order.last.payment_receipt}"
  end

  test "should show order" do
    get order_path(@order)
    assert_response :success
    assert_not_nil assigns(:previous_orders)
  end


end