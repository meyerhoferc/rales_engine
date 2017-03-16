class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find(params[:id])
  end

  def total_revenue
    total = Merchant.find_by(params[:id]).total_revenue
    render json: {"total_revenue": format_total(total)}
  end

  def format_total(total)
    (total.to_f / 100).round(2).to_s
  end


end
