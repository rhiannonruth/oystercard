class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAX_VALUE = 90
  MAX_VALUE_ERROR = "cannot have balance over #{MAX_VALUE}"
  MIN_VALUE = 1
  MIN_VALUE_ERROR = "balance is less than #{MIN_VALUE}"

  def initialize(balance=DEFAULT_BALANCE)
    @balance = DEFAULT_BALANCE
    @in_journey = false
  end

  def check_balance
    @balance
  end

  def top_up(value)
    raise MAX_VALUE_ERROR if balance + value > MAX_VALUE
    @balance += value
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "balance is less than 1" if balance < MIN_VALUE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MIN_VALUE)
  end

    private

    def deduct(value)
      @balance -= value
    end

end
