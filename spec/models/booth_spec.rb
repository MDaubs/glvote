require 'spec_helper'

describe Booth do
  it { should allow_value('Tom Smith').for(:voter_name) }
  it { should allow_value(nil).for(:voter_name) }
  it { should belong_to(:active_office) }
  it { should belong_to(:active_ballot) }

  class FakeState
    def human_status
      'Status'
    end

    def css_class
      'sparkle'
    end
  end

  before do
    FayeNotifier.stub(:publish)
  end

  describe "defaults" do
    let(:booth) { Booth.new }

    specify { booth.state.should be_a(InactiveState) }
    specify { booth.state_name.should == 'inactive_state' }
  end

  describe "#state=" do
    it "publishes an async message to /booths" do
      client = mock(Faye::Client)
      booth = Booth.create!(voter_name: 'Bob')
      FayeNotifier.should_receive(:publish).with('/booths',
                                                 id: booth.id,
                                                 voter_name: 'Bob',
                                                 human_status: 'Status',
                                                 css_class: 'sparkle')
      booth.state = FakeState
    end
  end

  describe "#activate!" do
    let(:mock_ballot) { mock_model(Ballot) }
    let(:mock_office) { mock_model(Office) }

    before do
      mock_ballot.stub(:save).and_return(true)
      Ballot.stub(:new).and_return(mock_ballot)
      Office.stub(:first).and_return(mock_office)
    end

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
      booth = Booth.create!
      booth.activate!('Tom Smith')
      booth.active_ballot.should be(mock_ballot)
    end

    it "sets #active_office to the first office" do
      booth = Booth.create!
      booth.activate!('Tom Smith')
      booth.active_office.should be(mock_office)
    end

    it "sets #state to ReadyState" do
      booth = Booth.new
      booth.activate!('Tom Smith')
      booth.state.should be_a(ReadyState)
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
      booth.state.should be_a(InactiveState)
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
end
