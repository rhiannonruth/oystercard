class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum balance exceeded" if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise "Not enough funds" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
