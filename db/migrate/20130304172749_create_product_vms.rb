class CreateProductVms < ActiveRecord::Migration
  def change
    create_table :product_vms do |t|

      t.timestamps
    end
  end
end
