class AddProductIdToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :product_id, :string
    add_column :line_items, :duration, :integer
    add_column :line_items, :duration_type, :string
  end
end
