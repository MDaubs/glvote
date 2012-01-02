require 'spec_helper'

describe State do
  let(:booth) { mock_model(Booth) }

  describe "#view_name" do
    it "defaults to the underscored name of the class" do
      class ThisIsAMockState < State
      end
      ThisIsAMockState.new(booth).view_name.should == 'this_is_a_mock'
    end
  end

  describe "#css_class" do
    it "defaults to 'important'" do
      State.new(booth).css_class.should == 'important'
    end
  end

  describe "#human_status" do
    it "defaults to 'Voting In Progress'" do
      State.new(booth).human_status.should == 'Voting In Progress'
    end
  end
end
