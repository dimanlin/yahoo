User.destroy_all
user = User.create(email: 'example@gmail.com', password: 'root0000', password_confirmation: 'root0000')
["YHOO", "GOOG", 'IDTI', 'IDU', 'IEX', 'IDXX'].each do |sym|
  user.stocks.create({name: sym, num: rand(99) + 1,})
end
