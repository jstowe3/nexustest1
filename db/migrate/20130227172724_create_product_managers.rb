class CreateProductManagers < ActiveRecord::Migration
  def change
    create_table :product_managers do |t|

      t.timestamps
    end
  end
end
