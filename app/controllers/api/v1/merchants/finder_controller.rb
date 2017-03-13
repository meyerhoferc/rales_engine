class Api::V1::Merchants::FinderController < ApplicationController
  def show
    finder = params.keys.first
    render json: Merchant.find_by(params.keys.first => params[finder])
  end

  def index
    finder = params.keys.first
    render json: Merchant.where(params.keys.first => params[finder])
  end

  def random
    render json: Merchant.all.sample
  end
end
