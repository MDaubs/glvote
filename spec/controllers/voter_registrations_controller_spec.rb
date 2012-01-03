require 'spec_helper'

describe VoterRegistrationsController do
  describe "POST #create", "as an election worker" do
    let(:registration) { mock_model(VoterRegistration, booth_id: 24) }

    before do
      VoterRegistration.stub(:new)
                       .with("booth_id" => "24", "voter_name" => "Tom Riddle")
                       .and_return(registration)
      registration.should_receive(:save).and_return(true)
      login_as_election_worker
      post :create, voter_registration: { "booth_id" => "24", "voter_name" => "Tom Riddle" }
    end

    it { should redirect_to(root_url) }
  end

  describe "POST #create", "without a valid login" do
    before do
      logout
      post :create
    end

    it { should redirect_to_login }
  end
end
