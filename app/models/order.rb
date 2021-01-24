class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  validates :date, presence: true
  validates :user_id, presence: true

  def self.delivered(yes)
    if yes
      where("delivered_at <= ?", Date.today)
    else
      where(delivered_at: nil)
    end
  end
end
