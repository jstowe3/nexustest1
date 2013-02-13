class OrderStartsController < ApplicationController
  # GET /order_starts
  # GET /order_starts.json


  def index
    @order_starts = OrderStart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_starts }
    end
  end

  def redirect
    @order_start = OrderStart.new(params[:order_start])
   # @order_start = OrderStart.find(params[:id])
    @email = @order_start.customer_email
    puts @email
  end
  # GET /order_starts/1
  # GET /order_starts/1.json
  def show
    @order_start = OrderStart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order_start }
    end
  end

  def purchase_orders
    puts "Redirecting to Purchase products"
  end

  # GET /order_starts/new
  # GET /order_starts/new.json
  def new
    @order_start = OrderStart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order_start }
    end
  end

  # GET /order_starts/1/edit
  def edit
    @order_start = OrderStart.find(params[:id])
  end

  # POST /order_starts
  # POST /order_starts.json
  def create
    @order_start = OrderStart.new(params[:order_start])

    respond_to do |format|
      if @order_start.save

      # format.html { redirect_to :controller => "customers", :action => "new"}
       #format.json { render json: @order_start, status: :created, location: @order_start }
       session[:cust_email] = @order_start.customer_email

      else
        format.html { render action: "new" }
        format.json { render json: @order_start.errors, status: :unprocessable_entity }
      end
    end
    redirect_to :controller => "customers", :action => "new"
  end

  # PUT /order_starts/1
  # PUT /order_starts/1.json
  def update
    @order_start = OrderStart.find(params[:id])

    respond_to do |format|
      if @order_start.update_attributes(params[:order_start])
        format.html { redirect_to @order_start, notice: 'Order start was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order_start.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_starts/1
  # DELETE /order_starts/1.json
  def destroy
    @order_start = OrderStart.find(params[:id])
    @order_start.destroy

    respond_to do |format|
      format.html { redirect_to order_starts_url }
      format.json { head :no_content }
    end
  end
end
