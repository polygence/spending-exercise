class Spending < ApplicationRecord

  # INITIALIZERS

  monetize :amount_cents, as: 'amount'

  # CONSTANTS

  DEFAULT_ORDER = lambda { |sps| sps.order(created_at: :desc) }

  ORDER_MAPPING = {
    '-date'          => DEFAULT_ORDER,
    'date'           => lambda { |sps| sps.order(created_at: :asc) },
    '-amount_in_huf' => lambda { |sps| sps.sort_by{ |sp| -sp.amount } },
    'amount_in_huf'  => lambda { |sps| sps.sort_by(&:amount) }
  }.freeze

  ALLOWED_CURRENCIES = [:huf, :usd].freeze

  # VALIDATIONS

  validates :description,  presence: true
  validates :currency,     presence: true
  validates :amount_cents, presence: true, numericality: { greater_than: 0 }

  # ASSOCIATIONS

  belongs_to :currency

  # SCOPES

  default_scope { includes(:currency) }

  # scope :huf, ....
  # scope :usd, ....
  ALLOWED_CURRENCIES.each do |scope_name|
    scope scope_name, -> { where(currencies: { name: scope_name.to_s }) }
  end

  # CLASS METHODS

  class << self
    def seed_data!(number = 15, range = 5000...10000)
      food_types = [ :dish, :fruits, :ingredient, :spice, :sushi, :vegetables ]
      currencies = Currency.all

      number.times do
        currency = currencies.sample
        money    = Money.new(rand(range), currency.name)
        Spending.create( currency: currency, amount: money, description: Faker::Food.send(food_types.sample))
      end
    end

    def filter_by params
      order_by   = ORDER_MAPPING[params[:order]] || DEFAULT_ORDER
      currency   = params[:currency].downcase.to_sym
      scope_name = currency.present? && ALLOWED_CURRENCIES.include?(currency) ? currency : :all
      send(scope_name).then(&order_by)
    end
  end

  # INSTANCE METHODS

  def spent_at
    created_at.iso8601
  end

  def amount_currency
    currency.name rescue MoneyRails.default_currency.iso_code
  end

  # SERIALIZERS

  def serialized_data
    serializable_hash(
      only: [:id, :description, :amount_cents],
      methods: :spent_at,
      include: { currency: { only: [ :name, :scale ] } }
    )
  end
end
