class BallotSelection < ActiveRecord::Base
  belongs_to :ballot
  belongs_to :candidate
  has_one    :office, :through => :candidate
end
