require 'test_helper'

class PurchaseControllerTest < ActionController::TestCase

   test "should show" do
     session[:billingType] = 'INRS'
     session[:resellerMasterAccountDID] = 'A41LH73VPINDONESIA'
     get :show, {:email => 'cbtest@cb.com'}
     assert_response :success
   end

   test "should confirm purchase" do

     session[:salesRepID] =  'INDEPENDENT'
     session[:partnerGroupID] = 'N3SH7C76LM1NYDND654'
     session[:partnerRepID] = 'NR7I7LJ6HYT5DG8HT5PK'
     session[:returnURL] = 'http://www.careerbuilder.com'
     session[:billingType] = 'INRS'
     session[:resellerMasterAccountDID]   = 'A41LH73VPINDONESIA'

     get :confirm_purchase,{:email => 'cbtest@cb.com' ,:AccountDID => 'AG18D45YJQQ0BV9FLP7'}
     assert_routing 'purchase/show',{:action => 'show',:controller => 'purchase'}
   end

end
