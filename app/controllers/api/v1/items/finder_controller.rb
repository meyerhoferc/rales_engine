class Api::V1::Items::FinderController < ApplicationController
  before_action :format_unit_price, only: [:index, :show]
  def show
    render json: Item.where(item_params).first
  end

  def index
    render json: Item.where(item_params)
  end

  private

  def item_params
    params.permit(:id, :created_at, :updated_at, :name, :description, :unit_price, :merchant_id)
  end
end
