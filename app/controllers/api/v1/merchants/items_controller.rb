class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: Merchant.find(params[:merchant_id]).items
  end

  def number_of_items_sold
    render json: Merchant.items_sold(params[:quantity])
  end
end
