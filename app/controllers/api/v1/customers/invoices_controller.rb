class Api::V1::Customers::InvoicesController < ApplicationController
  def index
    # byebug
    render json: Customer.find(params[:id]).invoices
  end
end
