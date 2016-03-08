require 'oystercard'

describe Oystercard do

  default_value = Oystercard::DEFAULT_BALANCE

  subject(:card) { described_class.new }

  describe '#initialize' do
    it 'is created with a balance' do
      expect(card.balance).to eq default_value
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

  end

end
