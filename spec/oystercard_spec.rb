require 'oystercard'

describe Oystercard do

let(:card) {Oystercard.new}

  describe 'balance' do

    it 'starts with a balance of 0' do
      expect(subject.check_balance).to eq 0
    end
  end

  describe 'Top-up' do
    it 'it should return the value it was top-uped with' do 
    expect(card.top_up(20)).to eq 20
    end
  end

end
