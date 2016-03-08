require 'oystercard'

describe Oystercard do

  it 'is initialized with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe "#top_up" do
    it "should top up card by specified amount" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "should raise an error if amount topped up makes the balance exceed 90£" do
      subject.top_up(10)
      expect{subject.top_up(90)}.to raise_error("Sorry, balance limit is 90£")
    end
  end

  describe "#deduct" do
    it "should deduct the specified amount from balance" do
      subject.top_up(10)
      subject.deduct(10)
      expect(subject.balance).to eq 0

    end
  end


end
