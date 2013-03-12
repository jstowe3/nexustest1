require 'test_helper'

class ProductVmTest < ActiveSupport::TestCase

  test 'test product view model' do

     product_vm = fill_product_vm()
     assert_equal('CBTestJob1',product_vm.job_products.map(&:description)[0])
     assert_equal('CBTestSub1',product_vm.subscription_products.map(&:description)[0])
  end

  def fill_product_vm()
      product_vm = ProductVM.new()
      product_vm.job_products << JobProducts.new('CBTestJob1')
      product_vm.subscription_products << SubscriptionProducts.new('CBTestSub1')
      product_vm
  end
end
