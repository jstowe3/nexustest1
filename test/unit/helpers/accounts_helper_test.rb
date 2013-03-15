require 'test_helper'
require 'rspec-rails'
require 'rspec/mocks'
require 'rspec/mocks/standalone'

class AccountsHelperTest < ActionView::TestCase
  test "get account view model test" do

    @account_mgr = AccountManager.new
    @account_mgr.customer_email = 'cbtest@cb.com'
    @account_mgr.reseller_master_account_did =  'A41LH73VPINDONESIA'
    @account_mgr.billing_type = 'INRS'
    @account_mgr.stub!(:find_account_for_customer).and_return({:websvc_response => 'Success', :account => account_mock })

    account = @account_mgr.find_account_for_customer[:account]
    name = account.name
    findex = name.index(' ')
    eindex = findex+1
    account_vm = AccountVM.new()
    account_vm.account_did = account.account_did
    account_vm.email = account.email
    account_vm.first_name = name[0,findex]
    account_vm.last_name =  name[eindex,name.length - findex]
    account_vm.city = account.city
    account_vm.state_country = account.state+' '+account.country
    account_vm.postal_code =  account.zip
    account_vm.company = account.company_name
    account_vm.phone = account.phone
    account_vm.address1 = account.address1
    account_vm.address2 = account.address2

    assert_equal 'CBFirst', account_vm.first_name
    assert_equal 'CBLast', account_vm.last_name
    assert_equal 'GAUS', account_vm.state_country
  end

  def account_mock
    account = Account.new
    account.name = 'CBFirst CBLast'
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
end
