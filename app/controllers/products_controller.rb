require 'savon'

class ProductsController < ApplicationController

  def index
    #@job_products = {:a => 'Job 1',:b => 'Job 2'}
    #@sub_products = {:c => 'Job 3', :c => 'Job 4'}
    @cart = current_cart
   getProducts()
  end

  def  getProducts()

    client = Savon::Client.new(wsdl: 'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?wsdl')
    response = client.call( :get_purchasable_products , message: {'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R','SecurityRole' => 'INDOReseller',
                                                                  'SystemScope' => 'Nexus'})
    @products = response.body[:get_purchasable_products_response][:ar_purchasable_product][:caws_purchasable_product];
    $i = 0
    $num = @products.count
    @job_products =[]
    @sub_products =[]
    @jobs = []
    @sub_jobs =[]
    while $i < $num  do
      if @products[$i][:display_group] == 'Job'
        @job_products << @products[$i][:display_name]   + ' ' +  @products[$i][:quantity] + ' Jobs'
        @jobs  << {:product_id => @products[$i][:product_id],:display_name => @products[$i][:display_name]}
      elsif @products[$i][:display_group] == 'Subscription'
        @sub_products << @products[$i][:display_name] + ' ' + @products[$i][:duration] + ' '+ @products[$i][:duration_type]
        @sub_jobs  << {:product_id => @products[$i][:product_id],:product_desc => @products[$i][:display_name]}
      end
      $i +=1
    end
  end

  def lineItemsPost

    @cart = current_cart
    @line_item = LineItem.new
  #  @line_item = @cart.line_items.build
    if params[:jobclick] != nil
      @line_item.product_desc = params[:job]
    elsif params[:subclick] != nil
       @line_item.product_desc = params[:sub_job]
    end
    @line_item.cart_id = @cart.id

    respond_to do |format|
      if @line_item.save
      #  format.html { redirect_to @line_item, notice: 'Line item was successfully created.' }
       # @line_items = LineItem.all
        #format.html {redirect_to @line_item.cart}
        format.html {redirect_to products_url}
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end


  end
end
