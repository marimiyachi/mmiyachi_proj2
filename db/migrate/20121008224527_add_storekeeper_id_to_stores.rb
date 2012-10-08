class AddStorekeeperIdToStores < ActiveRecord::Migration
  def change
    add_column :stores, :storekeeper_id, :integer
  end
end
