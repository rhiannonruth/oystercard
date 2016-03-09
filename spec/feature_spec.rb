require 'oystercard'

oystercard = Oystercard.new

oystercard.top_up(10)
p oystercard
oystercard.touch_in("Kings Cross")
# oystercard.touch_out
# p oystercard.journeys
