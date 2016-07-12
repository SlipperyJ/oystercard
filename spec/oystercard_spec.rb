require 'oystercard'
describe Oystercard do

  subject { Oystercard.new }

  it 'should have balance' do
    expect(subject).to receive(:balance)
    subject.balance
  end

context "top up"
  it { is_expected.to respond_to(:top_up).with(1).arguments }
  it "should be able to top up the balance" do
    expect { subject.top_up(10) }.to change { subject.balance }.by(10)
  end
end
