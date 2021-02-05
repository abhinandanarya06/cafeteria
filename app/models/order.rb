class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  validates :date, presence: true
  validates :user_id, presence: true

  def self.delivered(yes)
    if yes
      where("delivered_at <= ?", DateTime.now + 1)
    else
      where(delivered_at: nil)
    end
  end

  def self.create_from_cart(user_id)
    new_order = Order.create(
      date: Date.today,
      user_id: user_id,
    )
    user_cart = Cart.where(user_id: user_id)
    OrderItem.create_from_(user_cart, new_order)
    new_order
  end
end
