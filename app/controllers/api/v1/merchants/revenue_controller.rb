class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    Merchant.highest_revenue(params[:quantity])
  end
end
