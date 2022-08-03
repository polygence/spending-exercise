
FactoryBot.define do
  factory :huf_spending, class: "Spending" do
    description { Faker::Food.dish }
    amount { 1850 }
    currency { |c| Currency.find_by(name: "HUF") || c.association(:huf_currency) }
  end
end
