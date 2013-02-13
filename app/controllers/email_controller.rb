
require 'savon'

class EmailController < ApplicationController
  def emailAccept
    @cart = current_cart
  end
  def emailPost

    @custEmail = params[:custEmail]
    client = Savon::Client.new(wsdl: 'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?wsdl')
    response = client.call( :find_account_for_customer , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R','Email' => @custEmail,
                                                        'BillingType' => 'INRS', 'ResellerMasterAccountDID' => 'A41LH73VPINDONESIA'})
    response_text = response.body[:find_account_for_customer_response][:account]
    #
    #soap =    SOAP::WSDLDriverFactory.new('http://nexustest.careerbuilder.com/webservices/purchasing.asmx?WSDL').create_rpc_driver
    #response = soap.FindAccountForCustomer({'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R','Email' => @custEmail,
    #                                        'BillingType' => 'INRS', 'ResellerMasterAccountDID' => 'A41LH73VPINDONESIA'})
    #
    if response_text != nil
      name = response_text[:name]
      findex = name.index(' ')
      eindex = findex+1
      customerHash = {
          account_did: response_text[:account_did] ,
          email: @custEmail,
          firstname: name[0,findex],
          lastname: name[eindex,name.length - findex],
          city: response_text[:city],
          state: response_text[:state]+' '+response_text[:country],
          postalcode: response_text[:zip],
          company: response_text[:company_name],
          phone: response_text[:phone] ,
          address1: response_text[:address1]   ,
          address2: response_text[:address2]
      }
    else
      customerHash = {
          account_did: '',
          email: @custEmail,
          firstname: '',
          city: '',
          state: '',
          postalcode: '',
          company: '',
          phone: '' ,
          address1: ''   ,
          address2: ''
      }
    end

    redirect_to  :controller => 'email',:action => 'show' , :customerInfo => customerHash #:custEmail => @custEmail ,:firstName => 'Ram'
  end
  def show
    #  @custEmail = session[:custEmail]
    @cart = current_cart
    puts @custEmail
  end

  def customerPost
    saveUser()
    customerHash = {
        account_did: params[:AccountDID] ,
        email: params[:Email],
        firstname: params[:FirstName],
        lastname: params[:LastName],
        city: params[:City],
        state: params[:StateCountry],
        postalcode: params[:PostalCode],
        company: params[:Company],
        phone: params[:Phone] ,
        address1: params[:Address1]   ,
        address2: params[:Address2]}

    redirect_to :controller => 'confirm_purchase',:action => 'show' , :customerInfo => customerHash
  end

  def saveUser
    first_name = params[:FirstName]
    last_name = params[:LastName]
    company_name = params[:Company]
    address1 = params[:Address1]
    address2 = params[:Address2]
    city = params[:City]
    state = params[:StateCountry]
    zip = params[:PostalCode]
    email = params[:Email]
    phone = params[:Phone]
    master_account_did = 'A41LH73VPINDONESIA'
    account_did = params[:AccountDID]
    sales_rep_id = 'INDEPENDENT'


    client = Savon::Client.new(wsdl: 'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?wsdl')
    response = client.call( :save_sub_account , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R',
                                                          'MasterAccountDID' => master_account_did,'CompanyName' => company_name,
                                                          'FirstName' => first_name, 'LastName' =>last_name, 'Address1' => address1,
                                                          'Address2' => address2, 'City' => city, 'State' => 'GA', 'Zip' => zip,
                                                          'Country'=> 'US',
                                                           'Email' => email, 'Phone' => phone ,
                                                          'SalesRepID' => sales_rep_id ,'AccountDID' => account_did

    } )

    response_text = response.body[:save_sub_account_response][:save_sub_account_result]


  end

end
