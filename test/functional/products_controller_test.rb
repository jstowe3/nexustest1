require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should show product" do
    session[:securityRole] = 'INDOReseller'
    get :index
    assert_response :success
  end

  test "should line items post" do

    jobs = []
    jobs << {:product_id => 1,
              :product_desc => 'TestProduct',
              :quantity => 1,
              :duration => 12,
              :duration_type => 'Month'}

    session[:jobs] = jobs

    post :line_items_post, {:jobclick => 'true',:job => 'TestProduct'}
   # assert_response :success
    assert_redirected_to products_url
  end
end
