require 'savon'

class ProductManager

  attr_accessor :security_role, :client, :websvc_response,:error_message ,:contract_did
  attr_accessor :email, :account_did, :sales_rep_id, :partner_group_id, :partner_rep_id, :payment_method ,:products

  def  get_products()

    products = Products.new

    if @security_role == nil
      @websvc_response = 'Failure'
      return products
    end

    initialize()
    securityRole = @security_role
    #puts "Input parameter 1:" + securityRole
    response = @client.call( :get_purchasable_products , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R','SecurityRole' => securityRole,
                                                                   'SystemScope' => 'Nexus'})
    result = response.body[:get_purchasable_products_response]
    @websvc_response = result[:get_purchasable_products_result][:result]

    if result[:ar_purchasable_product] != nil
        $i = 0
        products_result = result[:ar_purchasable_product][:caws_purchasable_product]
        $num = products_result.count
        while $i < $num  do
          product = Product.new()
          product.product_id = products_result[$i][:product_id]
          product.price = products_result[$i][:price]
          product.quantity= products_result[$i][:quantity]
          product.duration= products_result[$i][:duration]
          product.duration_type=products_result[$i][:duration_type]
          product.display_group= products_result[$i][:display_group]
          product.display_name= products_result[$i][:display_name]
          product.prod_desc= products_result[$i][:prod_desc]

          products.product << product
          $i +=1
        end
    end
    products
  end

  def purchase_products

    initialize()
    response = @client.call( :purchase_products , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R',
                                                            'AccountDID' => @account_did,
                                                            'UserEmail' => @email,
                                                            'PaymentMethod' => @payment_method,
                                                            'SalesRepID' => @sales_rep_id  ,
                                                            'PartnerGroupID' => @partner_group_id,
                                                            'PartnerRepID' => @partner_rep_id,
                                                            'Products' => @products  })

    response_text = response.body[:purchase_products_response][:purchase_products_result]
    @websvc_response = response_text[:result]

    if @websvc_response == 'Failure'
       @error_message = response_text[:errors][:string][0]
    end

    @contract_did = response.body[:purchase_products_response][:contract_did]

    return @websvc_response

  end

  private

  def initialize
    @client = Savon::Client.new(wsdl: 'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?wsdl')
  end

end
