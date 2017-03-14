class Api::V1::Transactions::FinderController < ApplicationController

  def show
    byebug
    finder = params.keys[0]
    render json: Transaction.find_by(finder => params[finder])
  end

  def index
    finder = params.keys[0]
    render json: Transaction.where(finder => params[finder])
  end

  def random
    render json: Transaction.all.sample
  end

end
