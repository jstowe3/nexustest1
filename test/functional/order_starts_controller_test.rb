require 'test_helper'

class OrderStartsControllerTest < ActionController::TestCase
  setup do
    @order_start = order_starts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_starts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_start" do
    assert_difference('OrderStart.count') do
      post :create, order_start: { agency_email: @order_start.agency_email, customer_email: @order_start.customer_email }
    end

    assert_redirected_to order_start_path(assigns(:order_start))
  end

  test "should show order_start" do
    get :show, id: @order_start
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order_start
    assert_response :success
  end

  test "should update order_start" do
    put :update, id: @order_start, order_start: { agency_email: @order_start.agency_email, customer_email: @order_start.customer_email }
    assert_redirected_to order_start_path(assigns(:order_start))
  end

  test "should destroy order_start" do
    assert_difference('OrderStart.count', -1) do
      delete :destroy, id: @order_start
    end

    assert_redirected_to order_starts_path
  end
end
