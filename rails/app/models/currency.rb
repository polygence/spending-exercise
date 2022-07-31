class Currency < ApplicationRecord

  # VALIDATIONS

  validates :name,  presence: true, uniqueness: true
  validates :scale, presence: true, numericality: { only_integer: true }

  # CLASS METHODS

  class << self
    def seed_data!
      find_or_create_by(name: "HUF")
      find_or_create_by(name: "USD", scale: 2)
    end
  end
end
