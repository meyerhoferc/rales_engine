class Api::V1::Merchants::FinderController < ApplicationController
  def show
    render json: Merchant.find_by(merchant_params)
  end

  def index
    render json: Merchant.where(merchant_params)
  end

  private

  def merchant_params
    params.permit(:id, :created_at, :updated_at, :name)
  end
end
