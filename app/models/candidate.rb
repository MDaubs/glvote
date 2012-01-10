class Candidate < ActiveRecord::Base
  has_many :ballot_selections

  def photo_url
    "/candidates/#{self.id}.jpg"
  end
end
