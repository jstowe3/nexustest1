
require 'rubygems'

class CustomersController < ApplicationController
  # GET /customers
  # GET /customers.json
  def index
    @customer = Customer.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
   @customer = Customer.find(params[:id])
  #  @email = params[:custemail]
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new

    #@email = session[:cust_email]
    @email = 'mynextcar@yahoo.com'
   # @email = params[:custemail]
    # 'testcustomer@testcust.com'
   # @email = 'adehavn@alstin.com'
    @customer = Customer.new

    soap =    SOAP::WSDLDriverFactory.new(
        'http://nexustest.careerbuilder.com/webservices/purchasing.asmx?WSDL'
    ).create_rpc_driver


    response = soap.FindAccountForCustomer({'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R','Email' => @email,
                                            'BillingType' => 'INRS', 'ResellerMasterAccountDID' => 'A41LH73VPINDONESIA'})


      @customer.FirstName = response.account.name
      #@customer.LastName = "Ram Last"
      @customer.City = response.account.city
      @customer.StateCountry = response.account.state + ' '+response.account.country
      @customer.PostalCode = response.account.zip
      @customer.Company = response.account.companyName
      @customer.Phone = response.account.phone
      @customer.Address1 = response.account.address1
      @customer.Address2 = response.account.address2
      @customer.Email = response.account.email

    response2 = soap.getPurchasableProducts({'PartnerID' => 'Nexus','PartnerPassword' => 'R3S3LL3R','SecurityRole' => 'INDOReseller',
                                          'SystemScope' => 'Nexus'})

      @products = response2.arPurchasableProduct.cAWSPurchasableProduct
      $i = 0
      $num = @products.count
      @job_products =[]
      @sub_products =[]
      while $i < $num  do
          if @products[$i].displayGroup == 'Job'
            @job_products <<  @products[$i].displayName   + ' ' +  @products[$i].quantity + ' Jobs'
          elsif @products[$i].displayGroup == 'Subscription'
              @sub_products << @products[$i].displayName + ' ' + @products[$i].duration + ' '+ @products[$i].durationType
          end
        $i +=1
      end


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end

  def purchase
    #@customer = Customer.New
    #@customer = Customer.new
    #@cust_email = CustEmail.new


  end
  def accept
    @email = @customer.Email
  end

  def lineitemsave
    @line_item = LineItem.new
    @line_item.product = @job_products[0]
    @line_item.save()
  end

  end

