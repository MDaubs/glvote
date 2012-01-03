require 'spec_helper'

describe VoterRegistration do
  describe "#persisted?" do
    it "always returns false" do
      VoterRegistration.new.persisted?.should be_false
    end
  end

  describe "#id" do
    it "always returns nil" do
      VoterRegistration.new.id.should be_nil
    end
  end

  describe "#booth_id" do
    it "should allow assignment" do
      registration = VoterRegistration.new
      registration.booth_id = 17
      registration.booth_id.should == 17
    end
  end

  describe "#voter_name" do
    it "should allow assignment" do
      registration = VoterRegistration.new
      registration.voter_name = 'Bob'
      registration.voter_name.should == 'Bob'
    end
  end

  describe ".new" do
    it "should accept the booth_id parameter" do
      registration = VoterRegistration.new(booth_id: 17)
      registration.booth_id.should == 17
    end

    it "should accept the voter_name parameter" do
      registration = VoterRegistration.new(voter_name: 'Tom')
      registration.voter_name.should == 'Tom'
    end
  end

  describe "#save" do
    it "should activate the ballot" do
      booth = mock_model(Booth)
      booth.should_receive(:activate!).with('Tom')
      Booth.stub(:find).with(17).and_return(booth)
      registration = VoterRegistration.new(booth_id: 17, voter_name: 'Tom')
      registration.save.should be_true
    end
  end
end
