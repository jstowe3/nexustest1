require 'test_helper'
require 'savon'

class AccountsWebsvc < ActionDispatch::IntegrationTest

  def test_find_account_for_customer_websvc

    client = Savon::Client.new(wsdl: 'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?wsdl')

    response = client.call( :find_account_for_customer , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R',
                                                                    'Email' => 'cbtest@cb.com',
                                                                    'BillingType' => 'INRS',
                                                                    'ResellerMasterAccountDID' => 'A41LH73VPINDONESIA'})

    assert_equal 200, response.http.code
  end

  def test_save_sub_account_websvc
    client = Savon::Client.new(wsdl: 'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?wsdl')
    account = FillCustomer()
    response = client.call( :save_sub_account , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R',
                                                           'MasterAccountDID' => account.master_account_did,
                                                           'CompanyName' => account.company_name,
                                                           'FirstName' => account.first_name,
                                                           'LastName' =>account.last_name,
                                                           'Address1' => account.address1,
                                                           'Address2' => account.address2,
                                                           'City' => account.city,
                                                           'State' => account.state,
                                                           'Zip' => account.zip,
                                                           'Country'=> account.country,
                                                           'Email' => account.email,
                                                           'Phone' => account.phone ,
                                                           'SalesRepID' => account.sales_rep_id ,
                                                           'AccountDID' => account.account_did

    } )
    assert_equal 200, response.http.code
  end

  private

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

end
