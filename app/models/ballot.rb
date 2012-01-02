class Ballot < ActiveRecord::Base
  has_many :selections, :class_name => 'BallotSelection'
end
