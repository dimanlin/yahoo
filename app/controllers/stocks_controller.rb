class StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    @stocks = current_user.stocks
  end

  def show
    @stock = current_user.stocks.find(params[:id])

  end
end
