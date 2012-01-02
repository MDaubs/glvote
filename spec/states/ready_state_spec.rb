require 'spec_helper'

describe ReadyState do
  let(:booth) { mock_model(Booth) }

  it "transitions to VoterConfirmationState when begin is called" do
    booth.should_receive(:state=).with(VoterConfirmationState)
    state = ReadyState.new(booth)
    state.begin
  end

  specify { ReadyState.new(booth).css_class.should == 'success' }
  specify { ReadyState.new(booth).human_status.should == 'Ready For Voter' }
end
