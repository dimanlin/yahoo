class Stock < ActiveRecord::Base
  SYM = ["YHOO", "GOOG", 'IDTI', 'IDU', 'IEX', 'IDXX']

  belongs_to :user

  validates :name, :user_id, :num, presence: true
  validates :name, inclusion: { in: Stock::SYM }
  validates :num, numericality: true

end
