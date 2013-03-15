require 'test_helper'

class PurchaseControllerTest < ActionController::TestCase

   test "should show" do
     session[:billingType] = 'INRS'
     session[:resellerMasterAccountDID] = 'A41LH73VPINDONESIA'
     get :show, {:email => 'cbtest@cb.com'}
     assert_response :success
   end

   test "should show failure" do
     session[:billingType] = 'INRS'
     session[:resellerMasterAccountDID] = 'A41LH73VPINDONESIA'
     session[:email]  = 'cbtest@cb.com'
     get :show, {:email => nil}
     assert_response :success
   end

   test "should confirm purchase success" do

     session[:salesRepID] =  'INDEPENDENT'
     session[:partnerGroupID] = 'N3SH7C76LM1NYDND654'
     session[:partnerRepID] = 'NR7I7LJ6HYT5DG8HT5PK'
     session[:returnURL] = 'http://www.careerbuilder.com'
     session[:billingType] = 'INRS'
     session[:resellerMasterAccountDID]   = 'A41LH73VPINDONESIA'
      save_line_items()
     get :confirm_purchase,{:email => 'cbtest@cb.com' ,:AccountDID => 'AG18D45YJQQ0BV9FLP7'}
     assert_routing 'purchase/show',{:action => 'show',:controller => 'purchase'}
   end

   test "should confirm purchase failure" do

     session[:salesRepID] =  'INDEPENDENT'
     session[:partnerGroupID] = 'N3SH7C76LM1NYDND654'
     session[:partnerRepID] = 'NR7I7LJ6HYT5DG8HT5PK'
     session[:returnURL] = 'http://www.careerbuilder.com'
     session[:billingType] = 'INRS'
     session[:resellerMasterAccountDID]   = 'A41LH73VPINDONESIA'

     get :confirm_purchase,{:email => 'cbtest@cb.com' ,:AccountDID => 'AG18D45YJQQ0BV9FLP7'}
     assert_routing 'purchase/show',{:action => 'show',:controller => 'purchase'}
   end

  def save_line_items
   # @cart = current_cart
    @cart = Cart.new()
    @cart.save()
    current_cart = @cart
    @line_item = LineItem.new


    @line_item.product_desc = 'Job Product 1'
    @line_item.product_id = 'FPSBBINE'
    @line_item.quantity = 1
    @line_item.duration_type = 'Month'
    @line_item.duration = 12
    @line_item.cart_id = @cart.id
    @line_item.save()
  end

end
