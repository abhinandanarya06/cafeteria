class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :menu_items

  validates :user_id, presence: true
  validates :menu_item_id, presence: true
  validates :menu_item_name, presence: true, length: { minimum: 1 }
  validates :menu_item_price, presence: true
  validates :quantity, presence: true

  def self.item_for(item_id, user_id)
    Cart.all.where("menu_item_id = ? and user_id = ?", item_id, user_id)[0]
  end

  def self.addItem(params)
    user_id = params[:user_id]
    menu_item_id = params[:menu_item_id]
    quantity = params[:quantity]

    cart_item = Cart.item_for(menu_item_id, user_id)
    if cart_item
      cart_item.quantity += quantity.to_i
      cart_item.save
      return cart_item
    else
      menu_item = MenuItem.find_by_id(menu_item_id)
      return Cart.create(
               user_id: user_id,
               menu_item_id: menu_item_id,
               menu_item_name: menu_item.name,
               menu_item_price: menu_item.price,
               quantity: quantity,
             )
    end
  end
end
