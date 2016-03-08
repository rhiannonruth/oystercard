require 'oystercard'

describe Oystercard do

  default_value = Oystercard::DEFAULT_BALANCE


  subject(:card) { described_class.new }

  describe '#initialize' do

    it 'is created with a balance' do
      expect(card.balance).to eq default_value
    end
  end
end
