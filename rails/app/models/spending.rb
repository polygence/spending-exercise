class Spending < ApplicationRecord
  # VALIDATIONS

  validates :description, presence: true
  validates :currency,    presence: true
  validates :amount,      presence: true, numericality: { greater_than: 0 }

  # ASSOCIATIONS

  belongs_to :currency

  # SCOPES

  scope :with_currency, -> { includes(:currency) }

  # CLASS METHODS

  class << self
    def seed_data!(number = 15, range = 50.0...100.0)
      food_types = [ :dish, :fruits, :ingredient, :spice, :sushi, :vegetables ]
      currencies = Currency.all

      number.times do
        currency = currencies.sample
        amount   = rand(range).truncate(currency.scale)
        create(description: Faker::Food.send(food_types.sample), amount: amount, currency: currency)
      end
    end
  end

  # INSTANCE METHODS

  def spent_at
    created_at.iso8601
  end

  # SERIALIZERS

  def serialized_data
    serializable_hash(
      only: [:id, :description, :amount],
      methods: :spent_at,
      include: { currency: { only: [ :name, :scale ] } }
    )
  end
end
