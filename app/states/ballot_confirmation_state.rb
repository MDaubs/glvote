class BallotConfirmationState < State
  attr_accessor :flash_notice

  def cast_ballot(controller)
    booth.active_ballot.cast = true
    booth.state = InactiveState
    controller.redirect_to booth, notice: 'Your ballot has been cast.'
  end

  def previous
    booth.state = BallotSelectionState
  end
end
