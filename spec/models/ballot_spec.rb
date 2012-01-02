require 'spec_helper'

describe Ballot do
  it { should have_many(:selections) }
  it { should allow_value(true).for(:cast) }
  it { should allow_value(false).for(:cast) }
end
