require 'test_helper'

class AccountManagerTest < ActiveSupport::TestCase

  test "save sub account success" do
    account = FillCustomer()
    account_mgr = AccountManager.new()
    account_did = account_mgr.save_sub_account(account)
    assert_not_nil account_did
    assert_equal 'Success',account_mgr.websvc_response
  end


  test "save sub account failure" do
    account = FillCustomer()
    account.first_name = ''
    account.account_did = ''
    account_mgr = AccountManager.new()
    account_did = account_mgr.save_sub_account(account)
    assert_nil account_did
    assert_equal 'Error Saving Account: First Name cannot be empty',account_mgr.error_message
    assert_equal 'Failure',account_mgr.websvc_response
  end

  test "save sub account failure is going to fail" do
    account = FillCustomer()
    account.first_name = ''
    account.account_did = ''
    account_mgr = AccountManager.new()
    account_did = account_mgr.save_sub_account(account)
    assert_nil account_did

    assert_equal 'Error Saving Account: First Name cannot be ',account_mgr.error_message
    assert_equal 'Failure',account_mgr.websvc_response
  end

  def FillCustomer()
    account = Account.new()
    account.first_name = 'CBFirst'
    account.last_name = 'CBLast'
    account.company_name = 'CB'
    account.address1 = '123 ABC Street'
    account.address2 = ''
    account.city = 'Norcross'
    account.state = 'GA'
    account.country = 'US'
    account.postal_code = '30092'
    account.email = 'cbtest@cb.com'
    account.phone = '6782701000'
    account.master_account_did = 'A41LH73VPINDONESIA'
    account.zip = '30092'
    account.sales_rep_id = 'INDEPENDENT'
    account.account_did = 'AGR5FX6J1F3V7TQD42Q'
    return account
  end

  test "find account for customer success valid" do
    account_mgr = AccountManager.new()
    account_mgr.customer_email = 'cbtest@cb.com'
    account_mgr.reseller_master_account_did =  'A41LH73VPINDONESIA'
    account_mgr.billing_type = 'INRS'
    result = account_mgr.find_account_for_customer()
    assert_not_nil result
    assert_equal 'Success',account_mgr.websvc_response
  end

  test "find account for customer success invalid" do
    account_mgr = AccountManager.new()
    account_mgr.customer_email = 'cb99@cb.com'
    account_mgr.reseller_master_account_did =  'A41LH73VPINDONESIA'
    account_mgr.billing_type = 'INRS'
    result = account_mgr.find_account_for_customer()
    assert_nil result
    assert_equal 'Success',account_mgr.websvc_response
  end

  test "find account for customer failure with empty email" do
    account_mgr = AccountManager.new()
    #account_mgr.customer_email = 'ramtest10@cb.com'
    account_mgr.reseller_master_account_did =  'A41LH73VPTEST'
    account_mgr.billing_type = 'USRS'
    result = account_mgr.find_account_for_customer()
    assert_equal 'CustomerEmail cannot be empty',account_mgr.error_message
    assert_equal 'Failure',account_mgr.websvc_response
  end

  test "find account for customer failure with empty reseller master account did" do
    account_mgr = AccountManager.new()
    account_mgr.customer_email = 'ramtest10@cb.com'
    #account_mgr.reseller_master_account_did =  'A41LH73VPTEST'
    account_mgr.billing_type = 'USRS'
    result = account_mgr.find_account_for_customer()
    assert_equal 'ResellerMasterAccountDID cannot be empty',account_mgr.error_message
    assert_equal 'Failure',account_mgr.websvc_response
  end

  test "find account for customer failure with empty billing type" do
    account_mgr = AccountManager.new()
    account_mgr.customer_email = 'ramtest10@cb.com'
    account_mgr.reseller_master_account_did =  'A41LH73VPTEST'
    #account_mgr.billing_type = 'USRS'
    result = account_mgr.find_account_for_customer()
    assert_equal 'BillingType cannot be empty',account_mgr.error_message
    assert_equal 'Failure',account_mgr.websvc_response
  end

end
