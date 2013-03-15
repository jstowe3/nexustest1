require 'savon'

class AccountManager

  attr_accessor :customer_email, :billing_type, :reseller_master_account_did, :client,:websvc_response, :error_message

  def find_account_for_customer

    account = Account.new()
    if validate_input() == 'false'
      @websvc_response = 'Failure'
      return account
    end

    initialize()
    response = @client.call( :find_account_for_customer , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R','Email' => @customer_email,
                                                                    'BillingType' => @billing_type, 'ResellerMasterAccountDID' => @reseller_master_account_did})
    response_text = response.body[:find_account_for_customer_response]
    @websvc_response = response_text[:find_account_for_customer_result][:result]
    result = response_text[:account]
    if result != nil
      account.account_did = result[:account_did]
      account.name = result[:name]
      account.city = result[:city]
      account.state = result[:state]
      account.zip = result[:zip]
      account.zip_ext = result[:zip_ext]
      account.postal_code = result[:postal_code]
      account.country = result[:country]
      account.company_name = result[:company_name]
      account.phone = result[:phone]
      account.address1 = result[:address1]
      account.address2 = result[:address2]
      account.email = result[:email]
      account.master_account_did = result[:master_account_did]
    else
      account = nil

    end

    account

  end

  def validate_input

    if @customer_email == nil
      @error_message = 'CustomerEmail cannot be empty'
      return 'false'
    end
    if @billing_type == nil
      @error_message = 'BillingType cannot be empty'
      return 'false'
    end
    if @reseller_master_account_did == nil
      @error_message = 'ResellerMasterAccountDID cannot be empty'
      return 'false'
    end

    return 'true'
  end

  def save_sub_account(account)

    #client = Savon::Client.new(wsdl: 'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?wsdl')
    initialize()
    response = @client.call( :save_sub_account , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R',
                                                           'MasterAccountDID' => account.master_account_did,'CompanyName' => account.company_name,
                                                           'FirstName' => account.first_name, 'LastName' =>account.last_name, 'Address1' => account.address1,
                                                           'Address2' => account.address2, 'City' => account.city, 'State' => account.state, 'Zip' => account.zip,
                                                           'Country'=> account.country,
                                                           'Email' => account.email, 'Phone' => account.phone ,
                                                           'SalesRepID' => account.sales_rep_id ,'AccountDID' => account.account_did

    } )

    response_text = response.body[:save_sub_account_response][:save_sub_account_result]

    @websvc_response = response_text[:result]
    if @websvc_response == 'Failure'
        @error_message = response_text[:errors][:string]
    end

    account_did = response.body[:save_sub_account_response][:account_did]

  end

  private

  def initialize
    @client = Savon::Client.new(wsdl: 'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?wsdl')
  end

end
