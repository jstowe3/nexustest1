include PurchaseHelper
include AccountsHelper

class PurchaseController < ApplicationController

  def show
    @cart = current_cart

    account_mgr = AccountManager.new()
    account_mgr.billing_type = session[:billingType]
    email = params[:email]
    if email == nil
      error = true
      email = session[:email]
    end
    account_mgr.customer_email = email
    account_mgr.reseller_master_account_did =  session[:resellerMasterAccountDID]

    account = account_mgr.find_account_for_customer()

    @account_vm = get_account(account)

    if error
      @account_vm.error_message = 'Purchase Products Failed'
    end
    respond_to do |format|
      format.html
      format.json { render json: @account_vm }
    end
  end

  def confirm_purchase

    @cart = current_cart
    contract_did = purchase_products()
    session[:email] = nil

    if contract_did != nil
      @cart.destroy
      returnURL = session[:returnURL]
      paramsReset()
      redirect_to(returnURL)
    else
      session[:email] = params[:email]
      redirect_to action: 'show' ,:controller => 'purchase'
    end

  end

end
