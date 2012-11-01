class AddStoreIdToOrderIts < ActiveRecord::Migration
  def change
    add_column :order_its, :store_id, :integer
  end
end
