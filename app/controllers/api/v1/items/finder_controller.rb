class Api::V1::Items::FinderController < ApplicationController
  def show
    finder = params.keys[0]
    if finder.downcase == "id"
      render json: Item.find(params[finder.downcase])
    else
      render json: Item.find_by(finder => params[finder] )
    end
  end

  def index
    finder = params.keys[0]
    render json: Item.where("lower(#{finder}) = ?", params[finder].downcase)
  end

  def random
    render json: Item.all.sample
  end
end
