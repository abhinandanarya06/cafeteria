class Menu < ActiveRecord::Base
  scope :active, -> { where(active: true) }
  has_many :menu_items

  validates :name, presence: true, length: { minimum: 1 }
end
