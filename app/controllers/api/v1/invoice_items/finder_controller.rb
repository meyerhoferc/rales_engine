class Api::V1::InvoiceItems::FinderController < ApplicationController
  before_action :format_unit_price, only: [:index, :show]
  def show
    render json: InvoiceItem.find_by(invoice_item_params)
  end

  def index
    render json: InvoiceItem.where(invoice_item_params)
  end

  private

  def invoice_item_params
    params.permit(:item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, :id)
  end
end
