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
        @jobs << {:product_id => @products[$i][:product_id],
                   :product_desc => @products[$i][:display_name]   + ' ' +  @products[$i][:quantity] + ' Jobs',
                    :quantity => @products[$i][:quantity],
                    :duration => @products[$i][:duration],
                    :duration_type => @products[$i][:duration_type]}
      elsif @products[$i][:display_group] == 'Subscription'
        @sub_products << @products[$i][:display_name] + ' ' + @products[$i][:duration] + ' '+ @products[$i][:duration_type]
        @sub_jobs << {:product_id => @products[$i][:product_id],
                       :product_desc => @products[$i][:display_name] + ' ' + @products[$i][:duration] + ' '+ @products[$i][:duration_type],
                       :quantity => @products[$i][:quantity],
                       :duration => @products[$i][:duration],
                       :duration_type => @products[$i][:duration_type]}

      end
      $i +=1
    end
    session[:jobs] = @jobs
    session[:sub_jobs] = @sub_jobs
  end

  def find_product_details(product_desc,product_type)
    if product_type == 'Jobs'
      @products = session[:jobs]
    elsif product_type == 'SubJobs'
      @products = session[:sub_jobs]
    end

    $i = 0
    $num = @products.count
    @selected_product = []
    while $i < $num  do
      if @products[$i][:product_desc] == product_desc
        @selected_product = {:product_id => @products[$i][:product_id],
                             :quantity =>@products[$i][:quantity],
                              :duration => @products[$i][:duration],
                              :duration_type => @products[$i][:duration_type]}
      end
      $i +=1
    end
     @selected_product
  end

  def lineItemsPost

    @cart = current_cart
    @line_item = LineItem.new
  #  @line_item = @cart.line_items.build


    if params[:jobclick] != nil
      @line_item.product_desc = params[:job]
      find_product_details(params[:job],'Jobs')

    elsif params[:subclick] != nil
       @line_item.product_desc = params[:sub_job]
       find_product_details(params[:sub_job],'SubJobs')
    end
    @line_item.product_id = @selected_product[:product_id]
    @line_item.quantity = @selected_product[:quantity]
    @line_item.duration_type = @selected_product[:duration_type]
    @line_item.duration = @selected_product[:duration]
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
