# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# CREATE CURRENCIES

Currency.find_or_create_by(name: "HUF")
Currency.find_or_create_by(name: "USD", scale: 2)

# CREATE SPENDINGS

food_types = [ :dish, :fruits, :ingredient, :spice, :sushi, :vegetables ]
currencies = Currency.all

15.times do
  currency = currencies.sample
  amount   = rand(50.0...100.0).truncate(currency.scale)
  Spending.create(description: Faker::Food.send(food_types.sample), amount: amount, currency: currency)
end
