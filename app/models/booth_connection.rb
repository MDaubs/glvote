class BoothConnection
  extend  ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :booth_id

  def initialize(params = {})
    self.booth_id = params[:booth_id]
  end

  def id
    nil
  end

  def persisted?
    false
  end
end
