class Oystercard
  DEFAULT_BALANCE = 5

  attr_reader :balance

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    @balance += amount
  end

end
