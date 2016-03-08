class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station,:journeys, :exit_station

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "Maximum balance exceeded" if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(entry_station)
    raise "Not enough funds" if @balance < MINIMUM_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
    journey
  end

  private
  def deduct(amount)
    @balance -= amount
  end

  def journey
    @journeys << {:entry_station => @entry_station, :exit_station => @exit_station}
    @entry_station = nil
    @exit_station = nil 
  end
end
