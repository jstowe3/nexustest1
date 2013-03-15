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

  test "should line items post for jobs" do

    jobs = []
    jobs << {:product_id => 1,
              :product_desc => 'TestProduct1',
              :quantity => 1,
              :duration => 12,
              :duration_type => 'Month'}

    session[:jobs] = jobs

    post :line_items_post, {:jobclick => 'true',:job => 'TestProduct1'}
   # assert_response :success
    assert_redirected_to products_url
  end

  test "should line items post for subjobs" do

    sub_jobs = []
    sub_jobs << {:product_id => 2,
             :product_desc => 'TestProduct2',
             :quantity => 1,
             :duration => 12,
             :duration_type => 'Month'}

    session[:sub_jobs] = sub_jobs

    post :line_items_post, {:subclick => 'true',:sub_job => 'TestProduct2'}
    # assert_response :success
    assert_redirected_to products_url
  end
end
