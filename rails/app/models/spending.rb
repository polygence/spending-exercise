class Spending < ApplicationRecord
  # VALIDATIONS

  validates :description, presence: true
  validates :currency,    presence: true
  validates :amount,      presence: true, numericality: { greater_than: 0 }

  # ASSOCIATIONS

  belongs_to :currency

  # SCOPES

  scope :with_currency, -> { includes(:currency) }

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
