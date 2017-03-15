class Api::V1::Merchants::FinderController < ApplicationController
  def show
    finder = params.keys[0]
    render json: Merchant.find_by(finder => params[finder])
  end

  def index
    finder = params.keys[0]
    render json: Merchant.where(finder => params[finder])
  end
end
