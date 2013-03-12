module PurchaseHelper
  def purchase_products
    product_mgr = ProductManager.new()

    product_mgr.email = params[:email]
    product_mgr.account_did = params[:AccountDID]
    product_mgr.sales_rep_id = session[:salesRepID]
    product_mgr.partner_group_id = session[:partnerGroupID]
    product_mgr.partner_rep_id = session[:partnerRepID]
    product_mgr.payment_method = 'INV'

    #products = Products.new()
    caws_product = []
    #products = ProductsCollection.new()
    $i=0
    @cart.line_items.each do |item|
      #product = CAWSProduct.new()
      #caws_product.product_id = item.product_id
      #caws_product.price = 0.00
      #caws_product.quantity = item.quantity
      #caws_product.duration = item.duration
      #caws_product.duration_type = item.duration_type
      #caws_product.resume_geographic_scope = 'None'
      #caws_product.resume_geographic_value = ''
      #caws_product.start_dt = ''
      #caws_product.additional_info = ''

      #products << caws_product
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

    product_mgr.products = {
        'CAWSProduct' => caws_product
    }

    #product_mgr.products = products
    websvc_response = product_mgr.purchase_products()
    if websvc_response == 'Failure'
      contract_did = nil
    else
      contract_did = product_mgr.contract_did
    end

    return contract_did

  end
end
