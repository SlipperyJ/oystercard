require 'oystercard'

max_balance = Oystercard::MAX_BALANCE
min_balance = Oystercard::MIN_BALANCE

describe Oystercard do
let(:entry_station) { double :entry_station }
let(:exit_station) { double :exit_station }

  context "#balance" do
    it 'new oystercard has a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  context "#top_up" do
    it "should increase the balance by top up amount" do
      expect{subject.top_up(max_balance)}.to change{subject.balance}.by(max_balance)
    end

    it 'should throw an excption if balance exceeds 90' do
      expect{ subject.top_up(max_balance+max_balance) }.to raise_error 'Maximum amount exceeded'
    end
  end


  context "#in_journey" do
    it "should know if status is in_journey" do
      expect(subject).to respond_to(:in_journey?)
      expect(subject.in_journey?).to be_falsey
    end
  end

  context "#touch_in" do

    before :each do
      subject.top_up(min_balance)
      subject.touch_in(entry_station)
    end

    it "should allow a user to touch_in" do
      expect(subject).to be_in_journey
    end

    it "should prevent travelling when balance is below £1" do
      subject.touch_out(exit_station)
      expect{ subject.touch_in(entry_station) }.to raise_error "you need at least £1 to travel"
    end

    it "should deduct a penalty fare when touching in twice in a row" do
      expect{subject.touch_in(entry_station)}.to change{ subject.balance }.by(-Oystercard::PENALTY_CHARGE)
    end

  end

  context "#touch_out" do

    before :each do
      subject.top_up(min_balance)
      subject.touch_in(entry_station)
    end

    it "should allow a user to touch_out" do
      subject.touch_out(exit_station)
      expect(subject).to_not be_in_journey
    end

    it "should deduct minimum fare when touching out after touching in" do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-min_balance)
    end

    it "should deduct penalty fare when touching out without first touching in" do
      subject.touch_out(exit_station)
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::PENALTY_CHARGE)
    end

    it "should end journey on touch_out" do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it { is_expected.to respond_to(:touch_out).with(1).argument }
  end
  context "#journey_history" do
    it "should return a list of journeys made" do
      subject.top_up(max_balance)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history.last.entry_station).to eq entry_station
    end

    it "should be empty when initialized" do
      expect(subject.journey_history).to be_empty
    end
  end
end
