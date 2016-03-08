require 'oystercard'

describe Oystercard do

subject(:card) { described_class.new }

  describe '#balance' do

    it 'starts with a balance of 0' do
      expect(card.check_balance).to eq 0
    end
  end

  describe '#top-up' do
    it 'it should change the balance it was top-uped with' do
      card.top_up(20)
      expect(card.check_balance).to eq 20
    end
    it 'raises error when topped up over the limit' do
      card.top_up(Oystercard::MAX_LIMIT)
      expect { card.top_up(1) }.to raise_error Oystercard::MAX_LIMIT_ERROR
    end
  end

  describe '#deduct' do
    it 'it should deduct given value from the balance' do
      card.top_up(10)
      expect{ card.deduct(5) }.to change{ card.check_balance }.from(10).to(5)
    end
  end

end
