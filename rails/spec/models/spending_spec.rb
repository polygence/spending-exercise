require 'rails_helper'

RSpec.describe Spending, type: :model do
  describe "VALIDATIONS" do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe "ASSOCIATIONS" do
    it { is_expected.to belong_to :currency }
  end

  describe "INSTANCE METHODS" do
    let(:time) { Time.new(2002, 10, 31, 2, 2, 2, "UTC") }
    context ".spent_at" do
      before do
        subject.created_at = time
      end

      it "returns with the spending's created at as `iso8601`" do
        expect(subject.spent_at).to eq("2002-10-31T02:02:02Z")
      end
    end

    context ".serialized_data" do
      let(:spending) { create(:huf_spending, description: "Food", created_at: time) }
      let(:expected_serialized_data) {
        {
          id: 1,
          amount: 0.185e4,
          currency: { name: "HUF", scale: 0 },
          description: "Food",
          spent_at: time.iso8601
        }.with_indifferent_access
      }

      it "returns with the serialized spending data" do
        expect(spending.serialized_data).to eq(expected_serialized_data)
      end
    end
  end
end
