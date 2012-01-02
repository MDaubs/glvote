class VoterConfirmationState < State
  def yes
    booth.state = BallotInstructionsState
  end
end
