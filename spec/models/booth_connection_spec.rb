require 'spec_helper'

describe BoothConnection do
  describe "#persisted?" do
    it "always returns false" do
      BoothConnection.new.persisted?.should be_false
    end
  end

  describe "#id" do
    it "always returns nil" do
      BoothConnection.new.id.should be_nil
    end
  end

  describe "#booth_id" do
    it "should allow assignment" do
      connection = BoothConnection.new
      connection.booth_id = 17
      connection.booth_id.should == 17
    end
  end

  describe ".new" do
    it "should accept the booth_id parameter" do
      connection = BoothConnection.new(booth_id: 17)
      connection.booth_id.should == 17
    end
  end
end
