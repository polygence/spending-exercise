require 'rails_helper'

RSpec.describe Spending, type: :model do
  describe "VALIDATIONS" do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:amount_cents) }
    it { is_expected.to validate_numericality_of(:amount_cents).is_greater_than(0) }
    it { is_expected.to monetize(:amount_cents).as(:amount) }
  end

  describe "ASSOCIATIONS" do
    it { is_expected.to belong_to :currency }
  end

  describe "SCOPES" do
    let!(:huf_spendings) { create_list(:huf_spending, 4) }
    let!(:usd_spendings) { create_list(:usd_spending, 2) }

    context ".huf" do
      it "returns with the HUF spendings" do
        expect(described_class.huf).to match_array(huf_spendings)
      end
    end

    context ".usd" do
      it "returns with the USD spendings" do
        expect(described_class.usd).to match_array(usd_spendings)
      end
    end
  end

  describe "CLASS METHODS" do
    describe ".filter_by" do
      let(:huf_money) { Money.new(100, "HUF") }
      let(:usd_money) { Money.new(3, "USD") }
      let!(:huf_spending1) { create(:huf_spending) }
      let!(:huf_spending2) { create(:huf_spending, amount: huf_money) }
      let!(:usd_spending1) { create(:usd_spending) }
      let!(:usd_spending2) { create(:usd_spending, amount: usd_money) }

      context "when the filtering parameters are not handled" do
        let(:params) { {order: "+date", currency: "EUR"} }

        it "returns with the all spendings sorted by date descending (default)" do
          expect(described_class.filter_by(params)).to eq([usd_spending2, usd_spending1, huf_spending2, huf_spending1])
        end
      end

      context "when the filter is set to ALL" do
        context "and the ordering is 'Sort by Date descending (default)'" do
          let(:params) { {order: "-date", currency: ""} }

          it "returns with the all spendings sorted by date descending" do
            expect(described_class.filter_by(params)).to eq([usd_spending2, usd_spending1, huf_spending2, huf_spending1])
          end
        end

        context "and the ordering is 'Sort by Date ascending'" do
          let(:params) { {order: "date", currency: ""} }

          it "returns with the all spendings sorted by date ascending" do
            expect(described_class.filter_by(params)).to eq([huf_spending1, huf_spending2, usd_spending1, usd_spending2])
          end
        end

        context "and the ordering is 'Sort by Amount descending'" do
          let(:params) { {order: "-amount_in_huf", currency: ""} }

          it "returns with the all spendings sorted by amount descending" do
            expect(described_class.filter_by(params)).to eq([usd_spending1, huf_spending1, usd_spending2, huf_spending2])
          end
        end

        context "and the ordering is 'Sort by Amount ascending'" do
          let(:params) { {order: "amount_in_huf", currency: ""} }

          it "returns with the all spendings sorted by amount ascending" do
            expect(described_class.filter_by(params)).to eq([huf_spending2, usd_spending2, huf_spending1, usd_spending1])
          end
        end
      end

      Spending::ALLOWED_CURRENCIES.each do |currency_name|
        context "when filter is set to #{currency_name}" do
          let(:params) { {order: "-date", currency: currency_name} }

          it "it returns with the all #{currency_name} spendings sorted by date descending (default)" do
            expect(described_class.filter_by(params)).to eq([send(:"#{currency_name}_spending2"), send(:"#{currency_name}_spending1")])
          end
        end
      end
    end
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
          amount_cents: 0.185e4,
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
