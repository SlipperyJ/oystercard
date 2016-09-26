require 'station'

describe Station do

subject {described_class.new( name: "Old Street", zone: 1)}

	describe "initialize station" do

  	it "gets name variable" do
    	expect(subject.name).to eq("Old Street")
  	end
  	it "gets zone variable" do
    	expect(subject.zone).to eq(1)
  	end
	end
end
