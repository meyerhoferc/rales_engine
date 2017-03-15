class Api::V1::Merchants::CustomerController < ApplicationController
  def show
    render json: Merchant.find(params[:id]).favorite_customer
  end
end
