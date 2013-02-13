class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :FirstName
      t.string :LastName
      t.string :Company
      t.string :Address1
      t.string :Address2
      t.string :Email
      t.string :City
      t.string :StateCountry
      t.string :PostalCode
      t.string :Phone
      t.integer :PO
      t.timestamps
    end
  end
end
