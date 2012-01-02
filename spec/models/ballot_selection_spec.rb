require 'spec_helper'

describe BallotSelection do
  it { should belong_to(:ballot) }
  it { should belong_to(:candidate) }
  it { should have_one(:office).through(:candidate) }
end
