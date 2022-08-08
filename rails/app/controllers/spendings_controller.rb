class SpendingsController < ApplicationController

  def index
    render json: Spending.filter_by(filter_params).map(&:serialized_data)
  end

  private

  def filter_params
    params.permit(:order, :currency)
  end

end
