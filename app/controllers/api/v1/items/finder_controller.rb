class Api::V1::Items::FinderController < ApplicationController
  def show
    finder = params.keys.first
    render json: Item.find_by(params.keys.first => params[finder] )
  end
end
