module AccountsHelper

  def get_account(account)

    account_vm = AccountVM.new()

    if account != nil
      name = account.name
      findex = name.index(' ')
      eindex = findex+1

      account_vm.account_did = account.account_did
      account_vm.email = account.email
      account_vm.first_name = name[0,findex]
      account_vm.last_name =  name[eindex,name.length - findex]
      account_vm.city = account.city
      account_vm.state_country = account.state+' '+account.country
      account_vm.postal_code =  account.zip
      account_vm.company = account.company_name
      account_vm.phone = account.phone
      account_vm.address1 = account.address1
      account_vm.address2 = account.address2

      #customer_hash = {
      #    account_did: customer.account_did ,
      #    accounts: customer.accounts,
      #    firstname: name[0,findex],
      #    lastname: name[eindex,name.length - findex],
      #    city: customer.city,
      #    state: customer.state+' '+customer.country,
      #    postalcode: customer.zip,
      #    company: customer.company_name,
      #    phone: customer.phone ,
      #    address1: customer.address1   ,
      #    address2: customer.address2
      #}
    else
      account_vm.email = @custEmail

      #customer_hash = {
      #    account_did: '',
      #    accounts: @custEmail,
      #    firstname: '',
      #    city: '',
      #    state: '',
      #    postalcode: '',
      #    company: '',
      #    phone: '' ,
      #    address1: ''   ,
      #    address2: ''
      #}
    end

    account_vm

  end

  def set_account

    account = Account.new()

    account.first_name = params[:FirstName]
    account.last_name = params[:LastName]
    account.company_name = params[:Company]
    account.address1 = params[:Address1]
    account.address2 = params[:Address2]
    account.city = params[:City]
    state_country = params[:StateCountry]
    account.state = state_country[0,2]
    account.country = state_country[3,state_country.length]
    account.zip = params[:PostalCode]
    account.email = params[:Email]
    account.phone = params[:Phone]
    account.master_account_did = session[:resellerMasterAccountDID]
    account.account_did = params[:AccountDID]
    account.sales_rep_id = session[:salesRepID]
    account.name = params[:FirstName] + " " + params[:LastName]

    account

  end

end
