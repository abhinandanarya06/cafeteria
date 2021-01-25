# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Order.delete_all
Menu.delete_all
OrderItem.delete_all
MenuItem.delete_all
Cart.delete_all

User.create(
  name: "Admin",
  role: "Owner",
  email: "admin@admin.com",
  password: "admin",
)
