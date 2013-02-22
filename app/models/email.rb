class Email
  # attr_accessible :title, :body
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :FirstName, :City, :LastName, :StateCountry, :Company, :PostalCode, :Address1, :Address2, :Phone, :Email, :PO

  validates_presence_of :FirstName
  validates_presence_of :LastName
  validates_presence_of :Company
  validates_presence_of :Address1
  validates_presence_of :City
  validates_presence_of :StateCountry
  validates_presence_of :PostalCode
  validates_presence_of :Phone
  validates_format_of :Email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
