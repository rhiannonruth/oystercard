require_relative 'station'

class Oystercard
  MAXIMUM_BALANCE = 90
  MAXIMUM_BALANCE_ERROR = "cannot exceed maximum amount £#{MAXIMUM_BALANCE}"
  MINIMUM_BALANCE = 1
  MINIMUM_BALANCE_ERROR = 'insufficient funds.'
  MINIMUM_FARE = 2
  PENALTY_FARE = 6

  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @journeys = []
    @entry_station = nil
    @exit_station = nil
  end

  def top_up(amount)
    raise MAXIMUM_BALANCE_ERROR if @balance + amount > 90
    @balance += amount
  end

  def in_journey?
    !!@entry_station #!= nil
  end

  def touch_in(station)
    raise MINIMUM_BALANCE_ERROR if @balance < MINIMUM_BALANCE
    deduct(PENALTY_FARE) if entry_station != nil && exit_station == nil
    log_journey if entry_station != nil
    @entry_station = station
  end

  def touch_out(station)
    @exit_station = station
    entry_station == nil ? deduct(PENALTY_FARE) : deduct(MINIMUM_FARE)
    log_journey
    @entry_station = nil
    @exit_station = nil
  end


  private

  def log_journey
    current_journey = {:entry_station => @entry_station, :exit_station => @exit_station }
    @journeys << current_journey
  end

  def deduct(amount)
    @balance -= amount
  end

end
