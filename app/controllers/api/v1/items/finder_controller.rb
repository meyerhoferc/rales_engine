class Api::V1::Items::FinderController < ApplicationController
  before_action :format_unit_price, only: [:index, :show]

  def show
    finder = params.keys[0]
    render json: Item.find_by(finder => params[finder])
  end

  def index
    finder = params.keys[0]
    render json: Item.where(finder => params[finder])
  end

  def format_unit_price
    if params[:unit_price]
      unit_price = params[:unit_price].split(".").join
      params[:unit_price] = unit_price
    end
  end
end
