class Oystercard
  DEFAULT_BALANCE = 5
  MAXIMUM = 90

  attr_reader :balance

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    raise "cannot exceed maximum amount £#{MAXIMUM}" if @balance + amount > 90
    @balance += amount
  end

end
