require 'test_helper'
require 'savon'

class ProductsWebsvc < ActionDispatch::IntegrationTest

  def test_get_purchasable_products_websvc

    client = Savon::Client.new(wsdl: 'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?wsdl')
    response = client.call( :get_purchasable_products , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R','SecurityRole' => 'INDOReseller',
                                                                   'SystemScope' => 'Nexus'})
    assert_equal 200, response.http.code
  end

  def test_purchase_products_websvc
    client = Savon::Client.new(wsdl: 'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?wsdl')
    @account_did = 'AG18D45YJQQ0BV9FLP7'
    @email = 'cbtest@cb.com'
    @payment_method = 'INV'
    @sales_rep_id = 'INDEPENDENT'
    @partner_rep_id = 'NR7I7LJ6HYT5DG8HT5PK'
    @partner_group_id = 'N3SH7C76LM1NYDND654'
    caws_product = []
    caws_product[0] = {
        'ProductID' => 'FPSBBINE',  'Price' => 0.00,  'Quantity' => 1,  'Duration' => 12,  'DurationType'=> 'Month',
        'ResumeGeographicScope'=>'None',   'ResumeGeographicValue'=>'',  'StartDT' =>'',     'AdditionalInfo'=>''
    }
    @products = {
        'CAWSProduct' => caws_product
    }
    response = client.call( :purchase_products , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R',
                                                            'AccountDID' => @account_did, 'UserEmail' => @email,
                                                            'PaymentMethod' => @payment_method, 'SalesRepID' => @sales_rep_id  ,
                                                            'PartnerGroupID' => @partner_group_id,'PartnerRepID' => @partner_rep_id,
                                                            'Products' => @products  })
    assert_equal 200, response.http.code
  end
end
