require 'spec_helper'

describe BallotConfirmationState do
  describe "#cast_ballot" do
    it "casts the ballot" do
      controller = mock("MockController")
      ballot = mock_model(Ballot)
      booth = mock_model(Booth, active_ballot: ballot)
      ballot.should_receive(:cast=).with(true)
      booth.should_receive(:state=).with(InactiveState)
      controller.should_receive(:redirect_to).with(booth, notice: 'Your ballot has been cast.')
      state = BallotConfirmationState.new(booth)
      state.cast_ballot(controller)
    end
  end

  describe "#previous" do
    it "transitions to BallotSelection" do
      booth = mock_model(Booth)
      booth.should_receive(:state=).with(BallotSelectionState)
      state = BallotConfirmationState.new(booth)
      state.previous
    end
  end
end
