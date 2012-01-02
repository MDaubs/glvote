require 'spec_helper'

describe BallotSelectionState do
  describe "#next" do
    it "transitions to BallotConfirmationState when we have no next Office to set active" do
      active_office = mock_model(Office, id: 5)
      booth = mock_model(Booth, active_office: active_office)
      booth.should_receive(:state=).with(BallotConfirmationState)
      Office.stub(:where).with("id > 5").and_return([])
      state = BallotSelectionState.new(booth)
      state.next
    end

    it "sets the next Office as active if available" do
      active_office = mock_model(Office, id: 5)
      next_office = mock_model(Office, id: 6)
      booth = mock_model(Booth, active_office: active_office)
      booth.should_receive(:active_office=).with(next_office)
      Office.stub(:where).with("id > 5").and_return([next_office, "Don't pick me"])
      state = BallotSelectionState.new(booth)
      state.next
    end
  end

  describe "#previous" do
    it "transitions to BallotInstructionsState when we have previous Office to set active" do
      active_office = mock_model(Office, id: 5)
      booth = mock_model(Booth, active_office: active_office)
      booth.should_receive(:state=).with(BallotInstructionsState)
      Office.stub(:where).with("id < 5").and_return([])
      state = BallotSelectionState.new(booth)
      state.previous
    end

    it "sets the previous Office as active if available" do
      active_office = mock_model(Office, id: 5)
      previous_office = mock_model(Office, id: 4)
      booth = mock_model(Booth, active_office: active_office)
      booth.should_receive(:active_office=).with(previous_office)
      Office.stub(:where).with("id < 5").and_return(["Don't pick me", previous_office])
      state = BallotSelectionState.new(booth)
      state.previous
    end
  end
end
