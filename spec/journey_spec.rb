require "journey"
describe Journey do

  let(:entry_station) {double(:station)}
  let(:exit_station) {double(:station)}
  subject{described_class.new(entry_station)}

  it "should know its entry_station" do
    expect(subject.entry_station).to eq entry_station
  end

  it "finishes the journey" do
    expect(subject.finish_journey(exit_station)).to eq subject
  end

  context "#complete" do
  it "is not complete in the beginning" do
    expect(subject).not_to be_complete
  end

  it "is complete after finishing journey" do
    subject.finish_journey(exit_station)
    expect(subject).to be_complete
  end
  end
  context "#fare" do
    it "returns minimum_fare when it is complete" do
      subject.finish_journey(exit_station)
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end
    it "returns penalty fare when there is no exit station" do
      subject.finish_journey
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

  end
end
