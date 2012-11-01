class AddStatusToOrderIts < ActiveRecord::Migration
  def change
    add_column :order_its, :status, :string
  end
end
