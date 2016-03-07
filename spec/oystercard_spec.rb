require 'oystercard'

describe Oystercard do

  subject(:oystercard) {described_class.new}

  describe '#balance' do
    it 'initializes with an empty balance' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'increases balance by argument when you top up' do
      oystercard.top_up(25)
      expect(oystercard.balance).to eq 25
    end
  end

end
