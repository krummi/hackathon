class ReceiptItem < ActiveRecord::Base
  belongs_to :receipt

  attr_accessible :name, :price, :quantity, :receipt_id, :total, :letter
end
