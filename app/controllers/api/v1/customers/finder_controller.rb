class Api::V1::Customers::FinderController < ApplicationController

  def show
    finder = params.keys[0]
    if finder.downcase == "id"
      render json: Customer.find(params[finder.downcase])
    else
      render json: Customer.find_by("lower(#{finder}) = ?", params[finder].to_s.downcase)
    end
  end

  def index
    finder = params.keys[0]
    render json: Customer.where("lower(#{finder}) = ?", params[finder].downcase)
  end

  def random
    render json: Customer.all.sample
  end
end
