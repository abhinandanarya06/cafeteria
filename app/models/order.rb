class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  validates :date, presence: true
  validates :user_id, presence: true
  validates :delivered_at, presence: true
end
