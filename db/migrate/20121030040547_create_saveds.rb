class CreateSaveds < ActiveRecord::Migration
  def change
    create_table :saveds do |t|
      t.integer :storekeeper_id
      t.integer :item_id

      t.timestamps
    end
  end
end
