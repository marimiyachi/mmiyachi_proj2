class CreateOrderIts < ActiveRecord::Migration
  def change
    create_table :order_its do |t|
      t.integer :order_id
      t.integer :item_number

      t.timestamps
    end
  end
end
