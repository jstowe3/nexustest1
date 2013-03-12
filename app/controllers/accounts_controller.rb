include AccountsHelper

class AccountsController < ApplicationController

  def email_accept
    @cart = current_cart

    respond_to do |format|
      format.html
    end

  end

  def account_retrieve

    @cart = current_cart
    account_mgr = AccountManager.new()
    account_mgr.billing_type = session[:billingType]
    account_mgr.customer_email = params[:customer_email]
    account_mgr.reseller_master_account_did =  session[:resellerMasterAccountDID]
    @custEmail = params[:customer_email]
    account = account_mgr.find_account_for_customer()

    @account_vm = get_account(account)

    respond_to do |format|
      format.html {render :action => 'show', :account_vm => @account_vm}
      format.json { render json: @account_vm }
    end

    #redirect_to  :controller => 'accounts',:action => 'show' , :customerInfo => customer_hash

  end
  def show

    @cart = current_cart
    respond_to do |format|
      format.html
    end


  end

  def account_post

      @cart = current_cart
      account = set_account()
      account_mgr = AccountManager.new
      account_mgr.save_sub_account(account)

      respond_to do |format|
        format.html {redirect_to :controller => 'purchase', :action => 'show',:email =>account.email }
        #format.json { render json: @account_vm }
      end

      #redirect_to :controller => 'purchase',:action => 'show' , :customerInfo => customer_hash

  end


end
