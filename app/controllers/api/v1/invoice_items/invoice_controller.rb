class Api::V1::InvoiceItems::InvoiceController < ApplicationController
  def show
    render json: InvoiceItem.find_by(params[:invoice_id]).invoice
  end
end
