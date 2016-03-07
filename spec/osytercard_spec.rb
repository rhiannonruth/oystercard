require 'oystercard'

describe Oystercard do

  describe 'balance' do

    it 'starts with a balance of 0' do
      expect(subject.check_balance).to eq 0
    end
  end

end
