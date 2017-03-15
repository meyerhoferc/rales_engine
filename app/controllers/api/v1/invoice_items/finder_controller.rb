class Api::V1::InvoiceItems::FinderController < ApplicationController
  before_action :format_unit_price, only: [:index, :show]
  def show
    finder = params.keys[0]
    render json: InvoiceItem.find_by(finder => params[finder])
  end

  def index
    finder = params.keys[0]
    render json: InvoiceItem.where(finder => params[finder])
  end

  def format_unit_price
    if params[:unit_price]
      unit_price = params[:unit_price].split(".").join
      params[:unit_price] = unit_price
    end
  end
end
