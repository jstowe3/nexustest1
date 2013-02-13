class Customer < ActiveRecord::Base
  attr_accessible :Address1, :Address2, :City, :Company, :Email, :FirstName, :LastName, :PO, :Phone, :PostalCode, :StateCountry
end
