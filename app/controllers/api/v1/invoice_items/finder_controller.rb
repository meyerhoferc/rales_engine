class Api::V1::InvoiceItems::FinderController < ApplicationController
  def show
    finder = params.keys[0].downcase
    if finder == "id" || finder == "unit_price" || finder == "quantity"
      render json: InvoiceItem.find_by(finder => params[finder])
    else
      render json: InvoiceItem.find_by("lower(#{finder}) = ?", params[finder].to_s.downcase)
    end
  end

  def index
    finder = params.keys[0].downcase
    # byebug
    if finder == "id" || finder == "unit_price" || finder == "quantity"
      render json: InvoiceItem.where(finder => params[finder])
    else
      render json: InvoiceItem.where("lower(#{finder}) = ?", params[finder])
    end
  end
end
