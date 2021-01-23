class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :carts

  validates :name, presence: true, length: { minimum: 1 }
  validates :role, presence: true, inclusion: { in: ["Owner", "Billing Clerk", "Customer"],
                                                message: "%{value} is not a valid role" }
  validates :email, presence: true, length: { minimum: 1 }
end
