class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menu_item

  validates :order_id, presence: true
  validates :menu_item_id, presence: true
  validates :menu_item_name, presence: true, length: { minimum: 1 }
  validates :menu_item_price, presence: true
end
