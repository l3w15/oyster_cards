require "oystercard"

describe Oystercard do
  it "should have a balance" do
    expect(subject.balance).to eq 0
  end

  describe "#top_up" do
    it "should top up the balance by a specified amount" do
      expect { subject.top_up 20 }.to change { subject.balance }.by 20
    end

    it "should not top up over the card limit" do
      expect { subject.top_up 91 }.to raise_error "That top up would take you over your card limit of #{described_class::CARD_LIMIT}"
    end
  end
end
