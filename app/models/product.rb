
class Product
  attr_accessor :product_id, :price, :quantity, :duration, :duration_type, :display_group ,:display_name,:prod_desc
  #attr_accessor :resume_geographic_scope, :resume_geographic_value, :start_dt, :additional_info
 end


class Products

  attr_accessor :product

  def initialize(product=[])
    @product = product
  end

end


