class StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    @stocks = current_user.stocks
    yahoo_client = YahooFinance::Client.new
    @data = {}
    @stocks.map(&:name).each do |a|
      response = yahoo_client.historical_quotes(a.name, { start_date: 2.years.ago, end_date: Time::now })
      @data[a] = JSON.parse(response.to_json).collect {|a| a['table'].merge(a[close] * a.num)}
    end
  end

  def show
    @stock = current_user.stocks.find(params[:id])
  end
end
