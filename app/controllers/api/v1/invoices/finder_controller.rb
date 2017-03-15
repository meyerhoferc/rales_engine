class Api::V1::Invoices::FinderController < ApplicationController
  def show
    finder = params.keys[0]
    render json: Invoice.find_by(invoice_params)
  end

  def index
    finder = params.keys[0]
    render json: Invoice.where(invoice_params)
  end

  private

  def invoice_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end
