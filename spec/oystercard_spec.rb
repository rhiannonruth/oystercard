require 'oystercard'

describe Oystercard do

  default_value = Oystercard::DEFAULT_BALANCE
  maximum = Oystercard::MAXIMUM

  subject(:card) { described_class.new }

  describe '#initialize' do
    it 'initializes with a balance' do
      expect(card.balance).to eq default_value
    end

    it 'is created with in_journey attribute: false' do
      expect(card.touched_in).to eq false
    end
  end

  describe '#top_up' do
    it 'responds to a call to top up with an argument' do
      expect(card).to respond_to(:top_up).with(1).argument
    end

    it 'adds amount to existing balance' do
      amount = Random.rand(1..20)
      card.top_up(amount)
      expect(card.balance).to eq(default_value + amount)
    end

    it 'raise an error' do
      amount = Random.rand((90 - default_value)..100)
      message = "cannot exceed maximum amount £#{maximum}"
      expect{card.top_up(amount)}.to raise_error message
    end
  end

  describe '#deduct' do
    it 'responds to a call to deduct with an argument' do
      expect(card).to respond_to(:deduct).with(1).argument
    end

    it 'reduces current balance by defined amount' do
      current_balance = card.balance
      amount = Random.rand(2..7)
      card.deduct(amount)
      expect(card.balance).to eq(current_balance - amount)
    end

  end

  describe '#in_journey?' do
    it 'reveals whether the card is in journey (touched in)' do
      expect(card.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'changes touched_in to true' do
      card.touch_in
      expect(card.in_journey?).to eq true
    end
  end

  describe '#touch_out' do
    it 'changes touched_in to false' do
      card.touch_in
      card.touch_out
      expect(card.in_journey?).to eq false
    end
  end

end
