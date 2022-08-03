class SpendingsController < ApplicationController

  def index
    render json: Spending.with_currency.map(&:serialized_data)
  end

end
