require_relative "journey"
require_relative "station"

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :journeys

  def initialize
    @balance = 0
    @journeys = []
    @journey = Journey.new
  end

  def top_up(amount)
    raise "Maximum balance exceeded" if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Not enough funds" if @balance < MINIMUM_FARE
    @journey.start(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey.complete(station)
    log
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def log
    @journeys << {:entry_station => @journey.entry_station, :exit_station => @journey.exit_station}
    @journey = Journey.new
  end

end
