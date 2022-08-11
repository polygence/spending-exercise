FactoryBot.define do
  factory :huf_currency, class: "Currency" do
    name { "HUF" }
  end

  factory :usd_currency, class: "Currency" do
    name { "USD" }
  end
end
