class ReadyState < State
  def begin
    booth.state = VoterConfirmationState
  end

  def css_class
    'success'
  end

  def human_status
    'Ready For Voter'
  end
end
