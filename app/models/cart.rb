class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :menu_items

  validates :user_id, presence: true
  validates :menu_item_id, presence: true
  validates :menu_item_name, presence: true, length: { minimum: 1 }
  validates :menu_item_price, presence: true
  validates :quantity, presence: true
end
