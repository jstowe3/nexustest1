require 'test_helper'

class AccountVmTest < ActiveSupport::TestCase

  test "test account view model" do

    account_vm = fill_account_vm()

    assert_equal('CBFirst', account_vm.first_name)
    assert_equal('CBLast', account_vm.last_name)
  end

  def fill_account_vm
    account_mgr = AccountManager.new()
    account_mgr.customer_email = 'cbtest@cb.com'
    account_mgr.reseller_master_account_did =  'A41LH73VPINDONESIA'
    account_mgr.billing_type = 'INRS'
    account = account_mgr.find_account_for_customer()
    name = account.name
    findex = name.index(' ')
    eindex = findex+1

    account_vm = AccountVM.new()
    account_vm.first_name = name[0,findex]
    account_vm.last_name = name[eindex,name.length - findex]

    account_vm
  end
end
