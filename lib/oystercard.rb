class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MAX_LIMIT_ERROR = "cannot have balance over #{MAX_LIMIT}"

  def initialize(balance=DEFAULT_BALANCE)
    @balance = DEFAULT_BALANCE
  end

  def check_balance
    @balance
  end

  def top_up(value)
    raise MAX_LIMIT_ERROR if balance + value > MAX_LIMIT
    @balance += value
  end



end
