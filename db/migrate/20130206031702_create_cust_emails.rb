class CreateCustEmails < ActiveRecord::Migration
  def change
    create_table :cust_emails do |t|

      t.timestamps
    end
  end
end
