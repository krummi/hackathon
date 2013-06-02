class Receipt < ActiveRecord::Base
  has_many :receipt_items
  belongs_to :user
  belongs_to :store
  attr_accessible :store, :timestamp, :user_id, :store_id

  def total_amount
    sum = 0
    self.receipt_items.each { |i| sum += i.total }
    sum
  end

  def no_of_items
    self.receipt_items.length
  end
end
