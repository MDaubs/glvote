class VoterRegistration
  extend  ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :booth_id, :voter_name

  def initialize(params = {})
    self.booth_id   = params[:booth_id]
    self.voter_name = params[:voter_name]
  end

  def id
    nil
  end

  def persisted?
    false
  end

  def save
    Booth.find(self.booth_id).activate!(self.voter_name)
    true
  end
end
