require 'spec_helper'

describe Booth do
  it { should allow_value('Tom Smith').for(:voter_name) }
  it { should allow_value(nil).for(:voter_name) }
  it { should allow_value(true).for(:begin_pressed) }
  it { should allow_value(false).for(:begin_pressed) }
  it { should allow_value(true).for(:voter_name_confirmed) }
  it { should allow_value(false).for(:voter_name_confirmed) }
  it { should allow_value(true).for(:instructions_confirmed) }
  it { should allow_value(false).for(:instructions_confirmed) }
  it { should belong_to(:active_office) }
  it { should belong_to(:active_ballot) }

  describe "#activate!" do
    it "sets voter_name" do
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.voter_name.should == 'Tom Smith'
    end

    it "persists changes" do
      booth = Booth.create!
      booth.activate!('Tom Smith')
      booth.reload
      booth.voter_name.should == 'Tom Smith'
    end

    it "sets #active_ballot to a new ballot" do
      mock_ballot = mock_model(Ballot)
      mock_ballot.stub(:save).and_return(true)
      Ballot.stub(:new).and_return(mock_ballot)
      booth = Booth.create!
      booth.activate!('Tom Smith')
      booth.active_ballot.should be(mock_ballot)
    end

    it "sets #active_office to the first office" do
      mock_office = mock_model(Office)
      Office.stub(:first).and_return(mock_office)
      booth = Booth.create!
      booth.activate!('Tom Smith')
      booth.active_office.should be(mock_office)
    end

    it "clears voter_name_confirmed" do
      booth = Booth.create!
      booth.voter_name_confirmed = true
      booth.activate!('Tom Smith')
      booth.voter_name_confirmed.should be_false
    end

    it "clears instructions_confirmed" do
      booth = Booth.create!
      booth.instructions_confirmed = true
      booth.activate!('Tom Smith')
      booth.instructions_confirmed.should be_false
    end
  end

  describe "#deactivate!" do
    it "clears all state" do
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.deactivate!
      booth.voter_name.should be_nil
      booth.active_ballot.should be_nil
      booth.active_office.should be_nil
      booth.voter_name_confirmed.should be_false
      booth.instructions_confirmed.should be_false
    end
  end

  describe "#active?" do
    it "returns true if there is an active voter" do
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.should be_active
    end

    it "returns false if there is no active voter" do
      booth = Booth.new
      booth.should_not be_active
    end
  end

  describe "#booth_connection" do
    it "returns a new BoothConnection for this Booth" do
      booth      = Booth.find_or_create_by_id(17)
      connection = booth.booth_connection
      connection.should be_a(BoothConnection)
      connection.should be_new_record
      connection.booth_id.should == 17
    end
  end

  describe "#state" do
    before do
      Office.stub(:first).and_return(mock_model(Office))
    end

    it "returns 'inactive' by default" do
      booth = Booth.new
      booth.state.should == 'inactive'
    end

    it "returns 'ready' if activated but voter hasn't pressed begin" do
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.state.should == 'ready'
    end

    it "returns 'voter_confirmation' if activated and voter has pressed begin" do
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.begin_pressed = true
      booth.state.should == 'voter_confirmation'
    end

    it "returns 'ballot_instructions' if activated, voter has pressed begin, and confirmed their name" do
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.begin_pressed = true
      booth.voter_name_confirmed = true
      booth.state.should == 'ballot_instructions'
    end

    it "returns 'ballot_selection' if activated, voter has pressed begin, confirmed their name and instructions" do
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.begin_pressed = true
      booth.voter_name_confirmed = true
      booth.instructions_confirmed = true
      booth.state.should == 'ballot_selection'
    end

    it "returns 'ballot_confirmation' if activated, voter has pressed begin, confirmed their name and instructions, and there is no active office" do
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.begin_pressed = true
      booth.voter_name_confirmed = true
      booth.instructions_confirmed = true
      booth.active_office = nil
      booth.state.should == 'ballot_confirmation'
    end
  end

  describe "#active_selection" do
    it "returns a BallotSelection for the active_ballot" do
      mock_candidate = mock_model(Candidate, name: 'Mr. Candidate')
      mock_office = mock_model(Office, candidates: [mock_candidate])
      Office.stub(:first).and_return(mock_office)
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.active_selection.should be_a(BallotSelection)
      booth.active_selection.ballot.should == booth.active_ballot
    end
  end

  describe "#previous", "when state is 'ballot_selection'" do
    it "increments #active_office to the previous office when available" do
      current_office  = mock_model(Office)
      previous_office = mock_model(Office)
      Office.stub(:first).and_return(current_office)
      Office.stub(:where).with("id < #{current_office.id}").and_return(["DO NOT SELECT", previous_office])
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.begin_pressed = true
      booth.voter_name_confirmed = true
      booth.instructions_confirmed = true
      booth.previous
      booth.active_office.should == previous_office
    end

    it "sets #active_office to first office and clears instructions_confirmed when there is no previous office" do
      current_office = mock_model(Office)
      Office.stub(:first).and_return(current_office)
      Office.stub(:where).with("id < #{current_office.id}").and_return([])
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.begin_pressed = true
      booth.voter_name_confirmed = true
      booth.instructions_confirmed = true
      booth.previous
      booth.active_office.should == current_office
      booth.instructions_confirmed.should be_false
    end
  end

  describe "#cast_ballot", "when state is 'ballot_confirmation'" do
    let(:booth) { Booth.new }

    before do
      booth.activate!('Tom Smith')
      booth.begin_pressed = true
      booth.voter_name_confirmed = true
      booth.instructions_confirmed = true
      booth.active_office = nil
    end

    it "deactivates the booth" do
      booth.cast_ballot
      booth.state.should == 'inactive'
    end

    it "casts the active ballot" do
      ballot = booth.active_ballot
      ballot.should_not be_cast
      booth.cast_ballot
      ballot.should be_cast
      booth.active_ballot.should be_nil
    end
  end

  describe "#previous", "when state is 'ballot_confirmation'" do
    it "sets #active_office to the last office" do
      last_office = mock_model(Office)
      Office.stub(:last).and_return(last_office)
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.begin_pressed = true
      booth.voter_name_confirmed = true
      booth.instructions_confirmed = true
      booth.active_office = nil
      booth.state.should == 'ballot_confirmation'
      booth.previous
      booth.active_office.should == last_office
      booth.state.should == 'ballot_selection'
    end
  end

  describe "#next", "when state is 'ballot_selection'" do
    it "clears #active_office when there is no next office" do
      current_office = mock_model(Office)
      Office.stub(:first).and_return(current_office)
      Office.stub(:where).with("id > #{current_office.id}").and_return([])
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.begin_pressed = true
      booth.voter_name_confirmed = true
      booth.instructions_confirmed = true
      booth.next
      booth.active_office.should be_nil
    end

    it "increments #active_office to the next office when there is a next office" do
      current_office = mock_model(Office)
      next_office    = mock_model(Office)
      Office.stub(:first).and_return(current_office)
      Office.stub(:where).with("id > #{current_office.id}").and_return([next_office, "DO NOT SELECT"])
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.begin_pressed = true
      booth.voter_name_confirmed = true
      booth.instructions_confirmed = true
      booth.next
      booth.active_office.should == next_office
    end
  end
end
