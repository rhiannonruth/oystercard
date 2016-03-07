class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90
  MAX_BALANCE_ERROR = "maximum balance is £#{MAX_BALANCE}"

  def initialize
    @balance = 0
  end

  def top_up amount
    fail MAX_BALANCE_ERROR if (balance + amount) > MAX_BALANCE
    @balance += amount
  end

  def deduct amount
    @balance -= amount
  end
  
end
