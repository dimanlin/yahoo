class StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    @stocks = current_user.stocks.order('name')
  end
end
