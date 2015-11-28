class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stocks, dependent: :destroy

  @@yahoo_client = nil

  def portfolio_price(sym = nil)
    @@yahoo_client = YahooFinance::Client.new if @@yahoo_client.nil?
    @data = {}
    work_stocks = sym ? stocks.where(sym) : stocks

    work_stocks.each do |stock|
      instance_variable_set("@#{stock.name.downcase}", @@yahoo_client.historical_quotes(stock.name, { start_date: 2.years.ago, end_date: Time::now }))
    end

    result = {}
    ((Date.today - 2.years)..Date.today).each {|a| result.merge!(a.to_s(:db) => 0) }

    work_stocks.each do |stock|
      instance_variable_get("@#{stock.name.downcase}").each do |row|
        result[row.trade_date] = (result[row.trade_date].to_f + (row.close.to_f * stock.num)).round(4)
      end
    end

    result = result.map { |key, value| [key, value] }
    result.delete_if {|row| row.last == 0}
    result
  end
end
