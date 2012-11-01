class AddNameToOrderIts < ActiveRecord::Migration
  def change
    add_column :order_its, :name, :string
  end
end
