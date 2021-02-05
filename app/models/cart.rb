class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :menu_items

  validates :user_id, presence: true
  validates :menu_item_id, presence: true
  validates :menu_item_name, presence: true, length: { minimum: 1 }
  validates :menu_item_price, presence: true
  validates :quantity, presence: true

  def self.count_for(item, user)
    Cart.all.where("menu_item_id = ? and user_id = ?", item.id, user.id).count
  end
end
