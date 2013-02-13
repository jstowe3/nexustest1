class CreateOrderStarts < ActiveRecord::Migration
  def change
    create_table :order_starts do |t|
      t.string :customer_email
      t.string :agency_email

      t.timestamps
    end
  end
end
