require 'spec_helper'

describe BoothConnectionsController do
  describe "POST #create", "as an election worker" do
    before do
      login_as_election_worker
      post :create, booth_id: 24
    end

    it { should redirect_to(booth_url(24)) }
    it { should set_session(:booth_id).to(24) }
  end

  describe "POST #create", "without a valid login" do
    before do
      logout
      post :create, booth_id: 24
    end

    it { should_not set_session(:booth_id) }
    it { should redirect_to_login }
  end
end
