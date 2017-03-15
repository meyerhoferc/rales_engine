class Api::V1::Invoices::FinderController < ApplicationController
  def show
    finder = params.keys[0]
    render json: Invoice.find_by(finder => params[finder])
  end

  def index
    finder = params.keys[0]
    render json: Invoice.where(finder => params[finder])
  end
end
