class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0

  def initialize(balance=DEFAULT_BALANCE)
    @balance = DEFAULT_BALANCE
  end

  def check_balance
    @balance
  end

  def top_up(value)
    @balance += value
  end



end
