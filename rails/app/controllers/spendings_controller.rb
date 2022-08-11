class SpendingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Spending.filter_by(filter_params).map(&:serialized_data), code: 200, status: :ok
  end

  def create
    spending = Spending.new(create_params)
    if spending.save
      render json: spending.serialized_data, code: 201, status: :created
    else
      render json: { messages: spending.errors.full_messages }, code: 422, status: :unprocessable_entity
    end
  rescue StandardError => error
    Rails.logger.debug(error.message)
    render json: { messages: ["Something went wrong."] }, code: 500, status: :internal_server_error
  end

  def destroy
    spending = Spending.find(params[:id])
    spending.destroy
    render json: { message: "#{spending.description} is successfully deleted." }, code: 200, status: :ok
  rescue ActiveRecord::RecordNotFound => error
    Rails.logger.debug(error.message)
    render json: { messages: ["Couldn't find spending with id: #{params[:id]}"] }, code: 500, status: :internal_server_error
  end

  private

  def filter_params
    params.permit(:order, :currency)
  end

  def permitted_create_params
    params.require(:spending).permit(:description, :amount, :currency)
  end

  def create_params
    description, amount, currency = permitted_create_params.values_at(:description, :amount, :currency)
    {
      description: description,
      amount:      Money.new(amount.to_f * 100, currency),
      currency:    Currency.find_by(name: currency)
    }
  end
end
