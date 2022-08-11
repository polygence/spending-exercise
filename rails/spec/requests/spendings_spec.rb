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

  describe "POST /spendings" do
    let!(:currency) { create(:usd_currency) }
    let(:description) { "Test spending" }
    let(:amount) { 100.0 }
    let(:currency_name) { "USD" }

    before do
      post "/spendings", params: {spending: params}
    end

    context "when all parameters are set correctly" do
      let(:params) { {
        description: description,
        amount: amount,
        currency: currency_name
      } }

      it "returns with 201 HTTP code" do
        expect(response).to have_http_status(:created)
      end

      it "returns with the new spending as JSON" do
        resp = JSON.parse(response.body)
        expect(resp["description"]).to eq(description)
        expect(resp["amount_cents"]).to eq((amount * 100).to_s)
        expect(resp["currency"]["name"]).to eq(currency_name)
      end

      it "changes the count of the spendings" do
        expect { post "/spendings", params: {spending: params} }.to change { Spending.count }.from(1).to(2)
      end
    end

    context "when any mandatory parameter is missing" do
      let(:params) { {
        description: "",
        amount: "",
        currency: currency_name
      } }

      it "returns with 422 HTTP code" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns with validation error" do
        error_messages = JSON.parse(response.body)["messages"]
        expect(error_messages).to eq(["Description can't be blank", "Amount cents must be greater than 0"])
      end

      it "doesn't change the count of the spendings" do
        expect { post "/spendings", params: {spending: params} }.not_to change { Spending.count }
      end
    end

    context "when any error raised" do
      let(:params) { {
        description: description,
        amount: amount,
        currency: currency_name
      } }

      before do
        allow(Spending).to receive(:new).and_raise("boom")
        post "/spendings", params: {spending: params}
      end

      it "returns with 500 HTTP code" do
        expect(response).to have_http_status(:internal_server_error)
      end

      it "returns with 'Something went wrong.'" do
        error_messages = JSON.parse(response.body)["messages"]
        expect(error_messages).to eq(["Something went wrong."])
      end

      it "doesn't change the count of the spendings" do
        expect { post "/spendings", params: {spending: params} }.not_to change { Spending.count }
      end
    end
  end

  describe "DELETE /spendings" do
    let!(:spending) { create(:huf_spending) }

    before do
      delete "/spendings/#{spending.id}"
    end

    it "returns with 200 HTTP code" do
      expect(response).to have_http_status(:ok)
    end

    it "returns with a message about the deletation" do
      message = JSON.parse(response.body)["message"]
      expect(message).to eq("#{spending.description} is successfully deleted.")
    end

    it "returns with an error message" do
      delete "/spendings/9999999"
      error_messages = JSON.parse(response.body)["messages"]
      expect(error_messages).to eq(["Couldn't find spending with id: 9999999"])
    end
  end
end
