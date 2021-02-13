class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :carts

  validates :name, presence: true, length: { minimum: 1 }
  validates :role, presence: true, inclusion: { in: ["Owner", "Billing Clerk", "Customer"],
                                                message: "%{value} is not a valid role" }
  validates :email, presence: true, length: { minimum: 1 }, uniqueness: true

  scope :owners, -> { where("role = ?", "Owner") }
  scope :clerks, -> { where("role = ?", "Billing Clerk") }
  scope :customers, -> { where("role = ?", "Customer") }

  def is_owner?
    role == "Owner"
  end

  def is_clerk?
    role == "Billing Clerk"
  end

  def is_customer?
    role == "Customer"
  end
end
