class Api::V1::ItemsController < ApplicationController
  def index
    render json: Item.all
  end

  def show
    render json: Item.find(params[:id])
  end

  def most_items
    render json: Item.total_sold(params[:quantity])
  end

  def best_day
    render json: Item.find(params[:item_id]).highest_sale_date,
            serializer: ::DateSerializer
  end
end
