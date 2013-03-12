include ProductsHelper

class ProductsController < ApplicationController

  def index
    @cart = current_cart
    queryParams()

    product_mgr = ProductManager.new()
    product_mgr.security_role = session[:securityRole]
    products = product_mgr.get_products()

    @product_vm = split_products(products)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_vm }
    end
  end


  def line_items_post
    @cart = current_cart
    @line_item = LineItem.new

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
        format.html {redirect_to products_url}
        format.js  {@current_item = @line_item}
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end


end
