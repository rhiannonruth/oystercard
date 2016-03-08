class Oystercard
  DEFAULT_BALANCE = 5
  MAXIMUM = 90
  MINIMUM = 1

  attr_reader :balance, :touched_in

  def initialize
    @balance = DEFAULT_BALANCE
    @touched_in = false
  end

  def top_up(amount)
    raise "cannot exceed maximum amount £#{MAXIMUM}" if @balance + amount > 90
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @touched_in
  end

  def touch_in
    raise 'insufficient funds.' if @balance < MINIMUM
    @touched_in = true
  end

  def touch_out
    @touched_in = false
  end

end
