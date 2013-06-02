class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.datetime :timestamp
      t.integer :user_id
      t.integer :store_id

      t.timestamps
    end
  end
end
