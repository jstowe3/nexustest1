module ProductsHelper

  def split_products(products)

    $num = products.product.count
    @jobs = []
    @sub_jobs =[]
    $i = 0

    product_vm = ProductVM.new()

    while $i < $num  do
      if products.product[$i].display_group == 'Job'

        product_vm.job_products << JobProducts.new(products.product[$i].display_name   + ' ' +
                                                       products.product[$i].quantity + ' Jobs')


        @jobs << {:product_id => products.product[$i].product_id,
                  :product_desc => products.product[$i].display_name   + ' ' +  products.product[$i].quantity + ' Jobs',
                  :quantity => products.product[$i].quantity,
                  :duration => products.product[$i].duration,
                  :duration_type => products.product[$i].duration_type}
      elsif products.product[$i].display_group == 'Subscription'

        product_vm.subscription_products << SubscriptionProducts.new(products.product[$i].display_name + ' ' +
                                                                    products.product[$i].duration + ' '+
                                                                    products.product[$i].duration_type )

        @sub_jobs << {:product_id => products.product[$i].product_id,
                      :product_desc => products.product[$i].display_name + ' ' + products.product[$i].duration + ' '+ products.product[$i].duration_type,
                      :quantity => products.product[$i].quantity,
                      :duration => products.product[$i].duration,
                      :duration_type => products.product[$i].duration_type}

      end
      $i +=1
    end

    session[:jobs] = @jobs
    session[:sub_jobs] = @sub_jobs

    product_vm

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

end
