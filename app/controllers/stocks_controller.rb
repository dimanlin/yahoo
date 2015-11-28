class StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    @stocks = current_user.stocks
    @graph_data = current_user.portfolio_price(params[:stock])
  end

  def new
    @stock = current_user.stocks.new
  end

  def create
    if current_user.add_stocks(stock_params.merge(user_id: current_user.id))
      redirect_to stocks_path, notice: 'В портфель был обновлён.'
    else
      @stock = current_user.stocks.new(stock_params)
      @stock.valid?
      render action: :new
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:num, :name)
  end

end
