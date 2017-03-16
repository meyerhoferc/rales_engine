class Api::V1::InvoiceItems::ItemController < ApplicationController
  def show
    render json: InvoiceItem.find_by(id: item_params[:invoice_item_id]).item
  end

  def item_params
    params.permit(:invoice_item_id)
  end
end
