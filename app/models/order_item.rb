class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menu_item

  validates :order_id, presence: true
  validates :menu_item_id, presence: true
  validates :menu_item_name, presence: true, length: { minimum: 1 }
  validates :menu_item_price, presence: true

  def self.create_from_(user_cart, order)
    user_cart.each { |item|
      if !MenuItem.where(id: item.menu_item_id).empty?
        OrderItem.create!(
          order_id: order.id,
          menu_item_id: item.menu_item_id,
          menu_item_name: item.menu_item_name,
          menu_item_price: item.menu_item_price * item.quantity,
        )
        Cart.find_by(menu_item_id: item.menu_item_id).destroy
      end
    }
  end
end
