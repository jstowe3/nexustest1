class CreateProductViewModels < ActiveRecord::Migration
  def change
    create_table :product_view_models do |t|

      t.timestamps
    end
  end
end
