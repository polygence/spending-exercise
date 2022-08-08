
FactoryBot.define do
  factory :huf_spending, class: "Spending" do
    currency { |c| Currency.find_by(name: "HUF") || c.association(:huf_currency) }
    description { Faker::Food.dish }
    amount { Money.new(1850, "HUF") }
  end

  factory :usd_spending, class: "Spending" do
    currency { |c| Currency.find_by(name: "USD") || c.association(:usd_currency) }
    description { Faker::Food.dish }
    amount { Money.new(10.32, "USD") }
  end
end
