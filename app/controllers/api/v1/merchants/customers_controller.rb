class Api::V1::Merchants::CustomersController < ApplicationController
  def show
    render json: Merchant.find(params[:id]).favorite_customer
  end

  def index
    render json: Merchant.find(params[:id]).customers_with_pending_transactions
  end
end
