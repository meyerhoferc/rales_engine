class ApplicationController < ActionController::API
  def format_unit_price
    if params[:unit_price]
      unit_price = params[:unit_price].split(".").join
      params[:unit_price] = unit_price
    end
  end
end
