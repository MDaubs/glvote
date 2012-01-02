class InactiveState < State
  def css_class
    'notice'
  end

  def human_status
    'Inactive'
  end
end
