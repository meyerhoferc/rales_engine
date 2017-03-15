class Api::V1::InvoiceItems::ItemController < ApplicationController
  def show
    render json: InvoiceItem.find_by(params[:invoice_id]).item

  end
end
