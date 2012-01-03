require 'spec_helper'

describe HomeController do
  describe "GET index", "when not logged in" do
    before do
      get :index
    end

    it { should redirect_to_login }
  end

  describe "GET index", "when logged in" do
    let(:booths) { ["Booth 1","Booth 2"] }
    let(:registration) { mock_model(VoterRegistration) }

    before do
      session[:role] = 1
      VoterRegistration.stub(:new).and_return(registration)
      Booth.stub(:all).and_return(booths)
      get :index
    end

    it { should assign_to(:booths).with(booths) }
    it { should assign_to(:registration).with(registration) }
  end
end
