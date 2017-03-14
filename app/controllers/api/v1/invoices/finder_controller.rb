class Api::V1::Invoices::FinderController < ApplicationController
  def show
    finder = params.keys[0]
    if finder.downcase == "id"
      render json: Invoice.find(params[finder.downcase])
    else
      render json: Invoice.find_by(finder => params[finder])
    end
  end

  def index
    finder = params.keys[0]
    render json: Invoice.where(finder => params[finder] )
  end

  def random
    render json: Invoice.all.sample
  end
end
