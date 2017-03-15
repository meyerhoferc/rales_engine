class Api::V1::ItemsController < ApplicationController
  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id])
  end

  def most_revenue
    render json: Item.most_revenue(params[:quantity])
  end
end
