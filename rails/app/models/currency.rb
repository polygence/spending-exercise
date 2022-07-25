class Currency < ApplicationRecord

  # VALIDATIONS

  validates :name,  presence: true
  validates :scale, presence: true, numericality: { only_integer: true }
end
