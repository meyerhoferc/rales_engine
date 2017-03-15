class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: Merchant.highest_revenue(params[:quantity])
  end
end
