class Api::V1::Merchants::CustomersController < ApplicationController
  def show
    render json: Merchant.find(params[:id]).favorite_customer
  end

  def index
    render json: Merchant.customers_with_pending_transactions(params[:id]),
           each_serializer: ::CustomerSerializer
  end
end
