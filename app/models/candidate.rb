class Candidate < ActiveRecord::Base
  has_many :ballot_selections
end
