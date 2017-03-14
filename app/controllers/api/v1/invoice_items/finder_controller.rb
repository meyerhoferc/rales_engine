class Api::V1::InvoiceItems::FinderController < ApplicationController
  def show
    finder = params.keys[0]
    if finder.downcase == "id" || finder.downcase == "unit_price" || finder.downcase == "quantity"
      render json: InvoiceItem.find_by(finder.downcase => params[finder.downcase])
    else
      render json: InvoiceItem.find_by("lower(#{finder}) = ?", params[finder].to_s.downcase)
    end
  end
end
