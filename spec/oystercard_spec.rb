require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  describe '#balance' do
    it 'initializes with an empty balance' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'increases balance by argument when you top up' do
      expect{ oystercard.top_up 25 }.to change{ oystercard.balance }.by 25
    end

    it 'has a maximum balance of £90' do
      error = Oystercard::MAX_BALANCE_ERROR
      oystercard.top_up Oystercard::MAX_BALANCE
      expect{ oystercard.top_up 1 }.to raise_error error
    end
  end

  describe '#deduct' do
    it 'reduces balance by argument' do
      oystercard.top_up 25
      expect{ oystercard.deduct 5}.to change{ oystercard.balance }.by (-5)
    end
  end

end
