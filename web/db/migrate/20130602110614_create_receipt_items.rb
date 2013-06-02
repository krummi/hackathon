class CreateReceiptItems < ActiveRecord::Migration
  def change
    create_table :receipt_items do |t|
      t.integer :receipt_id
      t.string :letter
      t.string :name
      t.integer :quantity
      t.integer :price
      t.integer :total

      t.timestamps
    end
  end
end
