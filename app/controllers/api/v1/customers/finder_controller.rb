class Api::V1::Customers::FinderController < ApplicationController
  def show
    render json: Customer.find_by(customer_params)
  end

  def index
    render json: Customer.where(customer_params)
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :created_at, :updated_at, :id)
  end
end
