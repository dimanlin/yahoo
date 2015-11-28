class StocksController < ApplicationController
  before_action :authenticate_user!

  def index
    @stocks = current_user.stocks
    yahoo_client = YahooFinance::Client.new
    @data = {}
    @stocks.each do |stock|
      instance_variable_set("@#{stock}", yahoo_client.historical_quotes(name, { start_date: 2.years.ago, end_date: Time::now }))
    end

    @result = {}
    ((Date.today - 2.years)..Date.today).each {|a| @result.merge!(a.to_s(:db) => 0) }

    @stocks.each do |stock|
      instance_variable_get("@#{stock}").each do |row|
        @result[row['table']["trade_date"]] = result[row['table']["trade_date"]] + row['table']["close"] * stock.num
      end
    end
  end

  # def show
  #   @stock = current_user.stocks.find(params[:id])
  # end
end
