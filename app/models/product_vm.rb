class ProductVM

  attr_accessor :job_products, :subscription_products

  def initialize(job_products=[],subscription_products=[])
    @job_products, @subscription_products = job_products,subscription_products
  end

end

class JobProducts

  attr_accessor :description

  def initialize(description )
    @description = description
  end

end


class SubscriptionProducts

  attr_accessor :description

  def initialize(description )
    @description = description
  end

end

