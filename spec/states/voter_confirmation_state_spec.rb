require 'spec_helper'

describe VoterConfirmationState do
  it "transitions to BallotInstructionsState when yes is called" do
    booth = mock_model(Booth)
    booth.should_receive(:state=).with(BallotInstructionsState)
    state = VoterConfirmationState.new(booth)
    state.yes
  end
end
