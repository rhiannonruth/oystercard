require 'journey'

describe Journey do
  subject(:journey) {described_class.new}
  it {is_expected.to respond_to :make_journey}

  
end
