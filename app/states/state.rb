class State
  attr_accessor :booth

  def initialize(booth)
    self.booth = booth
  end

  def view_name
    self.class.to_s.underscore.gsub(/_state$/, '')
  end

  def css_class
    'important'
  end

  def human_status
    'Voting In Progress'
  end
end
