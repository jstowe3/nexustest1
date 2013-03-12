class CreateAccountVms < ActiveRecord::Migration
  def change
    create_table :account_vms do |t|

      t.timestamps
    end
  end
end
