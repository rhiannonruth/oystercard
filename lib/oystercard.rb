require 'station'

class Oystercard
  MAXIMUM = 90
  MINIMUM = 1
  MINIMUM_FARE = 2

  attr_reader :balance, :entry_station, :journeys

  def initialize (balance = 0)
    @balance = balance
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise "cannot exceed maximum amount £#{MAXIMUM}" if @balance + amount > 90
    @balance += amount
  end

  def in_journey?
    !!@entry_station #!= nil
  end

  def touch_in(entry_station)
    raise 'insufficient funds.' if @balance < MINIMUM
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    current_journey = {:entry_station => @entry_station, :exit_station => exit_station }
    @journeys << current_journey
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
