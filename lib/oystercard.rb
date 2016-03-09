require_relative "journey"
require_relative "station"

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
    @journey = Journey.new
  end

  def top_up(amount)
    raise "Maximum balance exceeded" if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Not enough funds" if @balance < MINIMUM_BALANCE
    no_touch_out if @journey.entry_station != nil && @journey.exit_station == nil
    @journey.start(station)
  end

  def touch_out(station)
    @journey.complete(station)
    deduct(@journey.fare)
    log
    @journey = Journey.new
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def no_touch_out
    deduct(@journey.fare)
    @journey.no_touch_out
    log
    @journey = Journey.new
  end

  def log
    @journey_history << @journey
  end

end
