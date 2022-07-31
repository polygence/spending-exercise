require 'rails_helper'

RSpec.describe Currency, type: :model do
  subject { build(:huf_currency) }

  describe "VALIDATIONS" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
    it { is_expected.to validate_presence_of(:scale) }
    it { is_expected.to validate_numericality_of(:scale) }
  end
end
