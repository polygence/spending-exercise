require 'rails_helper'

RSpec.describe "Spendings", type: :request do
  describe "GET /spendings" do
    let!(:spendings) { create_list(:huf_spending, 4) }

    before do
      get "/spendings?order=-date&currency="
    end

    it "responds with 200 OK" do
      expect(response.status).to eq(200)
    end

    it "contains the spendings" do
      expect(JSON.parse(response.body).count).to eq(4)
    end
  end
end
