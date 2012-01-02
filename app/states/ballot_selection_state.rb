class BallotSelectionState < State
  def next
    if next_office.present?
      booth.active_office = next_office
    else
      booth.state = BallotConfirmationState
    end
  end

  def previous
    if previous_office.present?
      booth.active_office = previous_office
    else
      booth.state = BallotInstructionsState
    end
  end

  private

  def next_office
    @next_office ||= Office.where("id > #{booth.active_office.id}").first
  end

  def previous_office
    @previous_office ||= Office.where("id < #{booth.active_office.id}").last
  end
end
