require_relative "../lib/oystercard"

oyster = Oystercard.new
oyster.top_up(20)
oyster.touch_in(:bond_st)
oyster.touch_out(:oxford_st)
p oyster.journeys
oyster.touch_in(:marble_arch)
oyster.touch_out(:holborn)
p oyster.journeys

oyster.touch_in(:aldgate)
oyster.touch_in(:aldgate_east)
p oyster.journeys
