require 'oystercard'

describe Oystercard do

subject(:card) {described_class.new}

  describe 'balance' do

    it 'starts with a balance of 0' do
      expect(card.check_balance).to eq 0
    end
  end

  describe 'Top-up' do
    it 'it should return the value it was top-uped with' do
      card.top_up(20)
      expect(card.check_balance).to eq 20
    end
  end

end
