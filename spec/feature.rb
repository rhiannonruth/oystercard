require_relative "../lib/oystercard"

oyster = Oystercard.new
oyster.top_up(20)
oyster.touch_in("Holborn")
oyster.touch_out("Covent Garden")
p oyster
p oyster.journeys

oyster.touch_in("Euston")
p oyster
