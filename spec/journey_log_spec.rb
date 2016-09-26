require 'journey_log'

describe JourneyLog do
  subject {described_class.new(Journey)}
  it "it takes a journey class" do
    expect(subject).to respond_to(:journey_class)
  end

  it "starts a journey" do
    expect(subject).to respond_to(:starting_journey)
  end

  it "ends a journey" do
    expect(subject).to respond_to(:ending_journey)
  end

  it "initializes a class with a starting point" do
    expect(subject.starting_journey("starting point")).to eq subject.instantiated_class
  endy
end
