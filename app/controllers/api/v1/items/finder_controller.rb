class Api::V1::Items::FinderController < ApplicationController
  before_action :format_unit_price, only: [:index, :show]

  def show
    render json: Item.find_by(item_params)
  end

  def index
    render json: Item.where(item_params)
  end

  private

  def item_params
    params.permit(:id, :created_at, :updated_at, :name, :description, :unit_price, :merchant_id)
  end

  def format_unit_price
    if params[:unit_price]
      unit_price = params[:unit_price].split(".").join
      params[:unit_price] = unit_price
    end
  end
end
