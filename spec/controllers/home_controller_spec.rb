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

    before do
      session[:role] = 1
      Booth.stub(:all).and_return(booths)
      get :index
    end

    it { should assign_to(:booths).with(booths) }
  end
end
