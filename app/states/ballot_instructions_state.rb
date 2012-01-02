class BallotInstructionsState < State
  def next
    booth.state = BallotSelectionState
  end
end
