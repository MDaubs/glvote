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
    deactivate
    self.voter_name = voter_name
    create_active_ballot
    self.active_office = Office.first
    save!
  end

  def deactivate!
    deactivate
    save!
  end

  def active?
    self.voter_name.present?
  end

  def booth_connection
    BoothConnection.new(booth_id: self.id)
  end

  def state
    if self.active?
      if self.begin_pressed?
        if self.voter_name_confirmed?
          if self.instructions_confirmed?
            if self.active_office.present?
              'ballot_selection'
            else
              'ballot_confirmation'
            end
          else
            'ballot_instructions'
          end
        else
          'voter_confirmation'
        end
      else
        'ready'
      end
    else
      'inactive'
    end
  end

  def next
    if self.state == 'ballot_selection'
      self.active_office = Office.where("id > #{self.active_office.id}").first
      save!
      return nil
    end
    nil
  end

  def previous
    if self.state == 'ballot_selection'
      previous_office = Office.where("id < #{self.active_office.id}").last
      if previous_office.present?
        self.active_office = previous_office
      else
        self.instructions_confirmed = false
      end
      save!
      return nil
    elsif self.state == 'ballot_confirmation'
      self.active_office = Office.last
      save!
      return nil
    end
    nil
  end

  def cast_ballot
    if self.state == 'ballot_confirmation'
      self.active_ballot.cast = true
      deactivate
      save!
      return 'Your ballot has been cast.'
    end
    nil
  end

  private

  def deactivate
    self.voter_name = nil
    self.voter_name_confirmed = false
    self.instructions_confirmed = false
    self.active_ballot = nil
    self.active_office = nil
  end
end
