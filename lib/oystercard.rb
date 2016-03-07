class Oystercard

  attr_reader :balance
  MAX_BALANCE_ERROR = "maximum balance exceeded"

  def initialize
    @balance = 0
  end

  def top_up amount
    fail MAX_BALANCE_ERROR if (balance + amount) > 90
    @balance += amount
  end
end
