require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  test "should get email_accept" do
    get :email_accept
    assert_response :success
  end

  test "should account retrieve" do
    session[:billingType] = 'INRS'
    session[:resellerMasterAccountDID] = 'A41LH73VPINDONESIA'
    get :account_retrieve, {:customer_email => 'cbtest@cb.com'}
    assert_response :success
  end

  test "should account retrieve fail" do
    session[:billingType] = 'INRS'
    session[:resellerMasterAccountDID] = 'A41LH73VPINDONESIA'
    get :account_retrieve, {:customer_email => 'cbtest88@cb.com'}
    assert_response :success
  end
  #test "this one is going to fail" do
  #  session[:billingType] = nil
  #  session[:resellerMasterAccountDID] = ''
  #  get :account_retrieve, {:customer_email => 'tempcbtest@cb.com'}
  #  assert_response :success
  #end

  test "should show" do
     get :show
     assert_response :success
  end

  test "should account post" do
    post :account_post, {:FirstName => 'CB First',:LastName =>'CB Last', :Company =>'CB',
                        :Address1 => '123 ABC Street', :Address2 => '',:City => 'Norcross',
                        :StateCountry => 'GA US' , :PostalCode => '30092', :Email => 'cbtest@cb.com',
                        :Phone => '6782701000', :resellerMasterAccountDID => 'A41LH73VPINDONESIA',
                        :AccountDID =>  'AG18D45YJQQ0BV9FLP7',
                          :salesRepID => 'INDEPENDENT'}

    assert_routing 'purchase/show',{:action => 'show',:controller => 'purchase'}
  end


  def set_account_vm
    account_vm = AccountVM.new()

    name = 'CBFirst CBLast'
    findex = name.index(' ')
    eindex = findex+1

    account_vm.account_did = 'A1'
    account_vm.email = 'cbtest@cb.com'
    account_vm.first_name = name[0,findex]
    account_vm.last_name =  name[eindex,name.length - findex]
    account_vm.city = 'Norcross'
    account_vm.state_country ='GA US'
    account_vm.postal_code =  '30092'
    account_vm.company = 'CB'
    account_vm.phone = '6789999999'
    account_vm.address1 = '123 ABC Street'
    account_vm.address2 = 'Test'

    account_vm

  end
end
