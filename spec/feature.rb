require_relative "../lib/oystercard"

oyster = Oystercard.new
oyster.top_up(30)
oyster.touch_in("Holborn")
oyster.touch_out("Covent Garden")
p oyster.balance
p oyster.journeys
p "**************************"

oyster.touch_in("Euston")
p oyster
p oyster.journeys # => Doesn't record journey or charge penalty fare when forget to touch out
p "**************************"

oyster.touch_in("Aldgate")
oyster.touch_out("Liverpool St")
p oyster.balance
p oyster.journeys
p "**************************"

oyster.touch_out("Bond St")
p oyster.balance
p oyster.journeys


#no touch out
oyster.touch_in("Euston")
deduct fare(penalty) if no touch out
