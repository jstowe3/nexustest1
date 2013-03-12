class ApplicationController < ActionController::Base
  protect_from_forgery



  private

   def current_cart
     Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
         cart = Cart.create
         session[:cart_id] = cart.id
         cart
   end

  def queryParams
    if session[:securityRole]==nil
      session[:securityRole] = params[:ResellerSecurityRole]
    end
    if session[:resellerMasterAccountDID]==nil
      session[:resellerMasterAccountDID] = params[:ResellerMasterAccountDID]
    end
    if session[:billingType]==nil
      session[:billingType] = params[:BillingType]
    end
    if session[:salesRepID]==nil
      session[:salesRepID] = params[:SalesRepID]
    end
    if session[:partnerRepID]==nil
      session[:partnerRepID] = params[:PartnerRepID]
    end
    if session[:partnerGroupID]==nil
      session[:partnerGroupID] = params[:PartnerGroupID]
    end
    if session[:returnURL]==nil
      session[:returnURL] = params[:ReturnURL]
    end
  end

  def paramsReset
    session[:cart_id] = nil
    session[:securityRole] = nil
    session[:resellerMasterAccountDID] = nil
    session[:billingType] = nil
    session[:salesRepID] = nil
    session[:salesRepID] = nil
    session[:partnerRepID] = nil
    session[:partnerGroupID] = nil
    session[:returnURL] = nil
    session[:email] = nil
  end

end
