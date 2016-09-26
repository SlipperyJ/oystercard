require './lib/oystercard.rb'
require './lib/station.rb'
card = Oystercard.new
card.top_up(10)

station1 = Station.new(name: "Bank", zone: 1)
station2 = Station.new(name: "Kings Cross", zone: 1)

card.touch_in(station1)
card.touch_out(station2)
p card.balance
