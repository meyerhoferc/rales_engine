class Api::V1::InvoiceItems::FinderController < ApplicationController
  def show
    finder = params.keys[0]
    render json: InvoiceItem.find_by(finder => params[finder])
  end

  def index
    finder = params.keys[0]
    render json: InvoiceItem.where(finder => params[finder])
  end

  def random
    render json: InvoiceItem.all.sample
  end
end
