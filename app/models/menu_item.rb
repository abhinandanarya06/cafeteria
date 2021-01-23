class MenuItem < ActiveRecord::Base
  belongs_to :menu

  validates :menu_id, presence: true
  validates :name, presence: true, length: { minimum: 1 }
  validates :price, presence: true
end
