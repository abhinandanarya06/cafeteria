class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :menu_items
end
