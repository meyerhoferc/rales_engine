class Api::V1::Customers::FinderController < ApplicationController

  def show
    finder = params.keys[0]
    render json: Customer.find_by(finder => params[finder])
  end

  def index
    finder = params.keys[0]
    render json: Customer.where("lower(#{finder}) = ?", params[finder].downcase)
  end

  def random
    render json: Customer.all.sample
  end
end
