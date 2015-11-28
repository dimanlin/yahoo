class StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    @stocks = current_user.stocks
    @graph_data = current_user.portfolio_price(params[:stock])
  end
end
