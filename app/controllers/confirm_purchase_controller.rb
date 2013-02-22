class ConfirmPurchaseController < ApplicationController
  def show
    @cart = current_cart
  end
  def customerPost
      # saveUser()

    @cart = current_cart
    purchaseProducts()
    @cart.destroy
    session[:cart_id] = nil
    session[:securityRole] = nil
    session[:resellerMasterAccountDID] = nil
    session[:billingType] = nil
    session[:salesRepID] = nil
    session[:salesRepID] = nil
    session[:partnerRepID] = nil
    session[:partnerGroupID] = nil
    returnURL = session[:returnURL]
    session[:returnURL] = nil

      #redirect_to :controller => 'products',:action => 'index'
       redirect_to(returnURL)
  end
  def purchaseProducts
    email = params[:Email]
    account_did = params[:AccountDID]
    sales_rep_id = session[:salesRepID]
    caws_product = []
    $i=0
    @cart.line_items.each do |item|
      caws_product[$i] = {
          'ProductID' => item.product_id,
          'Price' => 0.00,
          'Quantity' => item.quantity,
          'Duration' => item.duration,
          'DurationType'=> item.duration_type,
          'ResumeGeographicScope'=>'None',
          'ResumeGeographicValue'=>'',
          'StartDT' =>'',
          'AdditionalInfo'=>''
      }
      $i +=1
    end

    #@products = {'CAWSProduct' => caws_product}

    #@products = {['Products']['CAWSProduct'] => caws_product }
    partner_group_id = session[:partnerGroupID]
    partner_rep_id = session[:partnerRepID]
    payment_method = 'INV'
    client = Savon::Client.new(wsdl: 'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?wsdl')
    @products = {
        'CAWSProduct' => caws_product
        }
    response = client.call( :purchase_products , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R',
                                                           'AccountDID' => account_did,
                                                          'UserEmail' => email,
                                                          'PaymentMethod' => payment_method,
                                                          'SalesRepID' => sales_rep_id  ,
                                                          'PartnerGroupID' => partner_group_id,
                                                          'PartnerRepID' => partner_rep_id,
                                                          'Products' => @products  })

    @contract_did = response.body[:purchase_products_response][:contract_did]

  end

end
