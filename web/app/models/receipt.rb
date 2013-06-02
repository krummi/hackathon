class Receipt < ActiveRecord::Base
  has_many :receipt_items
  belongs_to :user
  belongs_to :store
  attr_accessible :store, :timestamp, :user_id, :store_id
end
