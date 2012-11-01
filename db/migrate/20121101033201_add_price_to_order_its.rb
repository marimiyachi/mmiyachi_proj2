class AddPriceToOrderIts < ActiveRecord::Migration
  def change
    add_column :order_its, :price, :float
  end
end
