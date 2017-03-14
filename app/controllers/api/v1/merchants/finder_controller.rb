class Api::V1::Merchants::FinderController < ApplicationController
  def show
    finder = params.keys.first
    render json: Merchant.find_by(finder => params[finder])
  end

  def index
    finder = params.keys.first
    render json: Merchant.where(finder => params[finder])
  end

  def random
    render json: Merchant.all.sample
  end
end
