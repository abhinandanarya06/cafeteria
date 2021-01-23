class Cart < ActiveRecord::Base
  belongs_to :users
  has_many :menu_items
end
