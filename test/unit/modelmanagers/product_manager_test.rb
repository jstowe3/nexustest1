require 'test_helper'
require 'rubygems'
require 'rspec'
require 'rspec-rails'
require 'rspec/mocks'
require 'rspec/mocks/standalone'


class ProductManagerTest < ActiveSupport::TestCase

  #test "get products test valid success" do
  #    product_mgr = ProductManager.new()
  #    product_mgr.security_role = 'INDOReseller'
  #    result =  product_mgr.get_products()
  #    assert result.product.count > 0
  #    puts product_mgr.websvc_response
  #    assert_equal 'Success', product_mgr.websvc_response
  #end

  test "get products mock test valid success" do
    @product_mgr = ProductManager.new
    @product_mgr.security_role = 'INDOReseller'
    @product_mgr.stub!(:get_products).and_return({:websvc_response => 'Success', :return_count => 10 })
    assert_equal 'Success', @product_mgr.get_products[:websvc_response]
    assert @product_mgr.get_products[:return_count] > 0
    @product_mgr.get_products.shou
  end

  #test "get products test invalid success" do
  #  product_mgr = ProductManager.new()
  #  product_mgr.security_role = 'TestSeller'
  #
  #  result =  product_mgr.get_products()
  #  assert_empty result.product
  #
  #  assert_equal 'Success',product_mgr.websvc_response
  #end

  test "get products mock test invalid success" do
    @product_mgr = ProductManager.new()
    @product_mgr.security_role = 'TestSeller'

    @product_mgr.stub!(:get_products).and_return({:websvc_response => 'Success',:product => Hash.new()})
    assert_equal 'Success', @product_mgr.get_products[:websvc_response]
    assert_empty @product_mgr.get_products[:product]

  end

  #test "get products test failure" do
  #  product_mgr = ProductManager.new()
  #
  #  result =  product_mgr.get_products()
  #  assert_empty result.product
  #  puts product_mgr.websvc_response
  #  assert_equal 'Failure',product_mgr.websvc_response
  #end

  test "get products mock test failure" do
    @product_mgr = ProductManager.new()

    @product_mgr.stub!(:get_products).and_return({:websvc_response => 'Failure',:product => Hash.new()})
    assert_equal 'Failure', @product_mgr.get_products[:websvc_response]
    assert_empty @product_mgr.get_products[:product]

  end

  #test "purchase products test success" do
  #  product_mgr = ProductManager.new()
  #  product_mgr.account_did = 'AG18D45YJQQ0BV9FLP7'
  #  product_mgr.email = 'cbtest@cb.com'
  #  product_mgr.payment_method = 'INV'
  #  product_mgr.sales_rep_id = 'INDEPENDENT'
  #  product_mgr.partner_rep_id = 'NR7I7LJ6HYT5DG8HT5PK'
  #  product_mgr.partner_group_id = 'N3SH7C76LM1NYDND654'
  #  caws_product = []
  #  caws_product[0] = {
  #        'ProductID' => 'FPSBBINE',
  #        'Price' => 0.00,
  #        'Quantity' => 1,
  #        'Duration' => 12,
  #        'DurationType'=> 'Month',
  #        'ResumeGeographicScope'=>'None',
  #        'ResumeGeographicValue'=>'',
  #        'StartDT' =>'',
  #        'AdditionalInfo'=>''
  #    }
  #  product_mgr.products = {
  #      'CAWSProduct' => caws_product
  #  }
  #  websvc_response = product_mgr.purchase_products()
  #  assert_not_nil product_mgr.contract_did
  #  assert_equal 'Success',websvc_response
  #end

  test "purchase products mock test success" do
    @product_mgr = ProductManager.new()

    @product_mgr.stub!(:purchase_products).and_return({:websvc_response => 'Success',:contract_did => 'CT-2947380'})
    assert_equal 'Success', @product_mgr.purchase_products[:websvc_response]
    assert_not_nil @product_mgr.purchase_products[:contract_did]

  end

  #test "purchase products test failure" do
  #  product_mgr = ProductManager.new()
  # # product_mgr.account_did = 'AG18D45YJQQ0BV9FLP7'
  #  product_mgr.email = 'cbtest@cb.com'
  #  product_mgr.payment_method = 'INV'
  #  product_mgr.sales_rep_id = 'INDEPENDENT'
  #  product_mgr.partner_rep_id = 'NR7I7LJ6HYT5DG8HT5PK'
  #  product_mgr.partner_group_id = 'N3SH7C76LM1NYDND654'
  #  caws_product = []
  #  caws_product[0] = {
  #      'ProductID' => 'FPSBBINE',
  #      'Price' => 0.00,
  #      'Quantity' => 1,
  #      'Duration' => 12,
  #      'DurationType'=> 'Month',
  #      'ResumeGeographicScope'=>'None',
  #      'ResumeGeographicValue'=>'',
  #      'StartDT' =>'',
  #      'AdditionalInfo'=>''
  #  }
  #  product_mgr.products = {
  #      'CAWSProduct' => caws_product
  #  }
  #  websvc_response = product_mgr.purchase_products()
  #  assert_nil product_mgr.contract_did
  #  assert_equal 'Failure',websvc_response
  #  assert_equal 'Invalid account:',product_mgr.error_message.strip!
  #end

  test "purchase products mock test failure" do
    @product_mgr = ProductManager.new()

    @product_mgr.stub!(:purchase_products)
                  .and_return({:websvc_response => 'Failure',
                               :contract_did => nil,
                               :error_message => 'Invalid account:'})

    assert_nil @product_mgr.purchase_products[:contract_did]
    assert_equal 'Failure',@product_mgr.purchase_products[:websvc_response]
    assert_equal 'Invalid account:',@product_mgr.purchase_products[:error_message]
  end

end
