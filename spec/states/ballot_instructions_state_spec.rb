require 'spec_helper'

describe BallotInstructionsState do
  it "transitions to BallotSelectionState when next is called" do
    booth = mock_model(Booth)
    booth.should_receive(:state=).with(BallotSelectionState)
    state = BallotInstructionsState.new(booth)
    state.next
  end
end
