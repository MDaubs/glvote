class Booth < ActiveRecord::Base
  belongs_to :active_ballot, :class_name => 'Ballot'
  belongs_to :active_office, :class_name => 'Office'

  default_scope :order => :id

  def active_selection
    existing_active_selection = self.active_ballot.selections.joins(:candidate).where("candidates.office_id" => self.active_office.id).first
    existing_active_selection || self.active_ballot.selections.new
  end

  def active_selection_attributes=(attributes)
    if self.active_selection.new_record?
      writable_active_selection = self.active_selection
    else
      writable_active_selection = BallotSelection.find(self.active_selection.id)
    end
    writable_active_selection.update_attributes(attributes)
  end

  def activate!(voter_name)
    self.voter_name = voter_name
    self.active_ballot = Ballot.new
    self.active_office = Office.first
    self.state = ReadyState
    save!
  end

  def deactivate!
    self.voter_name = nil
    self.active_office = nil
    self.active_ballot = nil
    self.state = InactiveState
    save!
  end

  def booth_connection
    BoothConnection.new(booth_id: self.id)
  end

  def state
    @state ||= self.state_name.camelize.constantize.new(self)
  end

  def state=(value)
    @state = nil
    if value.class == Class
      self.state_name = value.to_s.underscore
    else
      self.state_name = value.class.to_s.underscore
    end
    FayeNotifier.publish('/booths',
                         id: self.id,
                         voter_name: self.voter_name,
                         human_status: self.state.human_status,
                         css_class: self.state.css_class)
  end
end
