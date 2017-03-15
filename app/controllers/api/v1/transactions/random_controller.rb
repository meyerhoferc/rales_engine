class Api::V1::Transactions::RandomController < ApplicationController
  def show
    render json: Transaction.all.sample
  end
end
