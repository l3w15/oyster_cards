require "oystercard"

describe Oystercard do
  it "should have a balance" do
    expect(subject.balance).to eq 0
  end
end
