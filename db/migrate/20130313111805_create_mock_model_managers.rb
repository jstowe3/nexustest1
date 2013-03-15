class CreateMockModelManagers < ActiveRecord::Migration
  def change
    create_table :mock_model_managers do |t|

      t.timestamps
    end
  end
end
