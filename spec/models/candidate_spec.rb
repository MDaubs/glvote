require 'spec_helper'

describe Candidate do
  it { should have_many :ballot_selections }
  it "should have a photo_url" do
    candidate = Candidate.find_or_create_by_id(12)
    candidate.photo_url.should == '/candidates/12.jpg'
  end
end
